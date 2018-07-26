<?php

class Auth{
	public static function getToken($userId)
	{
		$conn = PDOConnection::getConnection();

		$token = md5(uniqid(rand(),1));
		$exp = mktime(date('H') + 2, date('i'), date('s'), date('m'), date('d'), date('Y'));

		try {
			$sql = "INSERT INTO sessions (session_id, session_exp, user_id) VALUES (:token, :exp, :user);";
			$stmt = $conn->prepare($sql);
			$stmt->bindParam(":token", $token, PDO::PARAM_STR, 32);
			$stmt->bindParam(":exp", $exp, PDO::PARAM_INT);
			$stmt->bindParam(":user", $userId, PDO::PARAM_INT);
			$stmt->execute();		
		} catch (PDOException $e) {
			echo "DataBase Error.<br/>" . $e->getMessage();
		} catch (Exception $e) {
			echo "General Error.<br/>" . $e->getMessage();
		}
		finally {
			$conn = null;
		}
		return $token;
	}

	public static function verifyToken($token = ""){
		$conn = PDOConnection::getConnection();

		try{
			$sql = "SELECT * FROM sessions WHERE session_id =:token";
			$stmt = $conn->prepare($sql);
			$stmt->bindParam(":token", $token, PDO::PARAM_STR, 32);
			$stmt->execute();

			$query = $stmt->fetchObject();

			if ($query) {
				if ($query->session_exp - time() > 0){
					return $query->user_id;
				}
			} else {
  				return false;
			}
		} catch (PDOException $e) {
			echo "DataBase Error.<br/>" . $e->getMessage();
		} catch (Exception $e) {
			echo "General Error.<br/>" . $e->getMessage();
		}
		finally {
			$conn = null;
		}
		return false;
	}
}