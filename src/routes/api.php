<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

$container = $app->getContainer();


$app->group('/api/v1', function () use ($app) {
	$app->get('/ping', function (Request $request, Response $response) {
		return "pong";
	});

	$app->post('/user/create', function(Request $request, Response $response) {
		
		$parsedBody = $request->getParsedBody();
		$username = $parsedBody['username'];
		$password = $parsedBody['password'];

		$conn = PDOConnection::getConnection();

		try {
			$sql = "INSERT INTO users (id, username, password) values(DEFAULT, :username, :password)";
			$stmt = $conn->prepare($sql);
			$stmt->bindParam(":username", $username, PDO::PARAM_STR, 80);
			$stmt->bindParam(":password", md5($password), PDO::PARAM_STR, 32);

			$stmt->execute();
			$query = $stmt->fetchObject();

			if ($query) {
				$data['success'] = "The user is created.";
			} else {
				$data['success'] = "The user is not created.";
			}

			$response = $response->withHeader('Content-Type', 'application/json');
			$response = $response->withStatus(200);
			$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
			return $response;
		} catch (PDOException $e) {
			echo "DataBase Error.<br/>" . $e->getMessage();
		} catch (Exception $e) {
			echo "General Error.<br/>" . $e->getMessage();
		}
		finally {
			$conn = null;
		}
	});

	$app->post('/user/login', function (Request $request, Response $response) {

		$parsedBody = $request->getParsedBody();
		
		$username = $parsedBody['username'];
		$password = $parsedBody['password'];

		$conn = PDOConnection::getConnection();

		try {
			$sql = "SELECT * FROM USERS WHERE username =:username AND password = :password";
			$stmt = $conn->prepare($sql);
			$stmt->bindParam(":username", $username, PDO::PARAM_STR, 80);
			$stmt->bindParam(":password", md5($password), PDO::PARAM_STR, 32);
			$stmt->execute();

			$query = $stmt->fetchObject();

			if ($query) {
				$data['token'] = Auth::getToken($query->id);;

			} else {
				$data['status'] = "Error: The user specified does not exist.";
			}

			$response = $response->withHeader('Content-Type', 'application/json');
			$response = $response->withStatus(200);
			$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
			return $response;
		} catch (PDOException $e) {
			echo "DataBase Error.<br/>" . $e->getMessage();
		} catch (Exception $e) {
			echo "General Error.<br/>" . $e->getMessage();
		}
		finally {
			$conn = null;
		}
	});

	/*получение рецепта*/
	$app->get('/recipe/{id}', function (Request $request, Response $response){
		$recipeId = $request->getAttribute("id");
		$conn = PDOConnection::getConnection();

		try {
			$sql = "
				SELECT recipe.id as id, recipe.name as name, recipe.text as text, images.img_path as img 
				FROM recipe 
				LEFT JOIN images ON recipe.img = images.id
				WHERE recipe.id = :id;
			";
			$stmt = $conn->prepare($sql);
			$stmt->bindParam(":id", intval($recipeId), PDO::PARAM_INT);
			$stmt->execute();

			$query = $stmt->fetchObject();

			if ($query) {
				$data['id'] = $query->id;
				$data['name'] = $query->name;
				$data['text'] = $query->text;
				$data['img'] = $query->img;
			} else {
				$data['status'] = "Error: recipe not found.";
			}

			$response = $response->withHeader('Content-Type', 'application/json');
			$response = $response->withStatus(200);
			$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
			return $response;
		} catch (PDOException $e) {
			echo "DataBase Error.<br/>" . $e->getMessage();
		} catch (Exception $e) {
			echo "General Error.<br/>" . $e->getMessage();
		}
		finally {
			$conn = null;
		}
	});

	/*создание рецепта*/
	$app->post('/recipe', function (Request $request, Response $response){
		$parsedBody = $request->getParsedBody();
		
		$token = htmlspecialchars($parsedBody['token']);
		
		if (!strlen($token)){
			$data['status'] = 'Не указано поле token';
			$response = $response->withHeader('Content-Type', 'application/json');
			$response = $response->withStatus(500);
			$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
			return $response;
		}

		$userId = Auth::verifyToken($token);

		if (!$userId){
			$data['status'] = "Недействительный токен.";
			$response = $response->withHeader('Content-Type', 'application/json');
			$response = $response->withStatus(200);
			$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
			return $response;
		}
		
		$name = htmlspecialchars($parsedBody['name']);
		$text = htmlspecialchars($parsedBody['text']);
		$img = intval($parsedBody['img']);

		$conn = PDOConnection::getConnection();

		try {
			$sql = "INSERT INTO recipe (id, name, text, img, user_id) VALUES (DEFAULT, :name, :text, :img, :user_id)";
			$stmt = $conn->prepare($sql);
			$stmt->bindParam(":name", $name, PDO::PARAM_STR, 80);
			$stmt->bindParam(":text", $text, PDO::PARAM_STR);
			$stmt->bindParam(":img", $img, PDO::PARAM_STR);
			$stmt->bindParam(":user_id", intval($userId), PDO::PARAM_STR);
			$stmt->execute();

			$query = $stmt->fetchObject();

			if ($query) {
				$id = $conn->lastInsertId();
				$data['recipe'] = "/api/v1/recipe/{$id}";

			} else {
				$data['status'] = "Error";
			}

			$response = $response->withHeader('Content-Type', 'application/json');
			$response = $response->withStatus(200);
			$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
			return $response;
		} catch (PDOException $e) {
			echo "DataBase Error.<br/>" . $e->getMessage();
		} catch (Exception $e) {
			echo "General Error.<br/>" . $e->getMessage();
		}
		finally {
			$conn = null;
		}
	});

	/*изменение рецепта*/
	$app->post('/recipe/{id}', function (Request $request, Response $response){
		$parsedBody = $request->getParsedBody();
		$name = htmlspecialchars($parsedBody['name']);
		$text = htmlspecialchars($parsedBody['text']);
		$img = intval($parsedBody['img']);

		$recipeId = intval($request->getAttribute("id"));

		$token = htmlspecialchars($parsedBody['token']);
		$userId = Auth::verifyToken($token);

		if (!$userId){
			$data['status'] = "Invalid token.";
			$response = $response->withHeader('Content-Type', 'application/json');
			$response = $response->withStatus(200);
			$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
			return $response;
		}
		
		if (!strlen($name)){
			$data['status'] = 'Не указано поле name';
			$response = $response->withHeader('Content-Type', 'application/json');
			$response = $response->withStatus(400);
			$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
			return $response;
		}

		$conn = PDOConnection::getConnection();

		try {
  			$sql = "UPDATE recipe SET";
  			$sql .= " name = :name";
  			if (isset($text) && strlen($text) > 0){
				$sql .= ", text = :text";
  			}
  			if (isset($img) && $img > 0){
				$sql .= ", img = :img";
  			}
			$sql .= " WHERE ID = :id AND user_id = :user_id";
			
			$stmt = $conn->prepare($sql);
			$stmt->bindParam(":name", $name, PDO::PARAM_STR, 80);

  			if (isset($text) && strlen($text) > 0){
				$stmt->bindParam(":text", $text, PDO::PARAM_STR);
  			}

  			if (isset($img) && $img > 0){
				$stmt->bindParam(":img", $img, PDO::PARAM_STR);
  			}

			$stmt->bindParam(":id", $recipeId);
			$stmt->bindParam(":user_id", $userId);
			$stmt->execute();

			$query = $stmt->fetchObject();

			if ($query) {
				$data['status'] = "Updated.";

			} else {
				$data['status'] = "Error";
			}

			$response = $response->withHeader('Content-Type', 'application/json');
			$response = $response->withStatus(200);
			$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
			return $response;
		} catch (PDOException $e) {
			echo "DataBase Error.<br/>" . $e->getMessage();
		} catch (Exception $e) {
			echo "General Error.<br/>" . $e->getMessage();
		}
		finally {
			$conn = null;
		}
	});

	/*удаление рецепта*/
	$app->post('/recipe/delete/{id}', function (Request $request, Response $response){
		$parsedBody = $request->getParsedBody();
		$recipeId = intval($request->getAttribute("id"));

		$token = htmlspecialchars($parsedBody['token']);
		$userId = Auth::verifyToken($token);

		if (!$userId){
			$data['status'] = "Недействительный токен.";
			$response = $response->withHeader('Content-Type', 'application/json');
			$response = $response->withStatus(200);
			$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
			return $response;
		}

		$conn = PDOConnection::getConnection();

		try {
  			$sql = "DELETE FROM recipe WHERE id = :id AND user_id = :user_id;";
			
			$stmt = $conn->prepare($sql);

			$stmt->bindParam(":id", $recipeId);
			$stmt->bindParam(":user_id", $userId);
			$stmt->execute();

			$query = $stmt->fetchObject();

			if ($query) {
				$data['status'] = "Deleted.";

			} else {
				$data['status'] = "Error";
			}

			$response = $response->withHeader('Content-Type', 'application/json');
			$response = $response->withStatus(200);
			$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
			return $response;
		} catch (PDOException $e) {
			echo "DataBase Error.<br/>" . $e->getMessage();
		} catch (Exception $e) {
			echo "General Error.<br/>" . $e->getMessage();
		}
		finally {
			$conn = null;
		}
	});

	//загрузка изображения
	$app->post('/upload', function(Request $request, Response $response) {
	    $directory = UPLOAD_DIR;
	    $web_directory = WEB_UPLOAD_DIR;

	    $uploadedFiles = $request->getUploadedFiles();

	    $uploadedFile = $uploadedFiles['image'];
	    if (!$uploadedFile->getError()) {
	        $filename = Upload::moveUploadedFile($directory, $uploadedFile);

			$conn = PDOConnection::getConnection();

			try {
	  			$sql = "INSERT INTO images (id, img_path) VALUES (DEFAULT, :filename);";
				
				$stmt = $conn->prepare($sql);
				$filename = $web_directory.$filename;
				$stmt->bindParam(":filename", $filename);
				$stmt->execute();

				$query = $stmt->fetchObject();

				if ($query) {
					$id = $conn->lastInsertId();
					$data['img'] = $id;
					$response = $response->withStatus(200);
				} else {
					$data['status'] = "Error";
					$response = $response->withStatus(500);
				}

				$response = $response->withHeader('Content-Type', 'application/json');
				$response = $response->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT));
				return $response;
			} catch (PDOException $e) {
				echo "DataBase Error.<br/>" . $e->getMessage();
			} catch (Exception $e) {
				echo "General Error.<br/>" . $e->getMessage();
			}
			finally {
				$conn = null;
			}
	    }

	});


});