<?php

/**
 * Class PDO Connection
 */
class PDOConnection
{

	private function __construct()
	{
	}

	public static function getConnection()
	{
		$host = DB_HOST;
		$port = DB_PORT;
		$user = DB_USER;
		$pass = DB_PASS;
		$name = DB_NAME;

		$dsn = "pgsql:host=$host;port=$port;dbname=$name;user=$user;password=$pass";

		try {
			$connection = new PDO($dsn, $user, $pass);
			$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$connection->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
			$connection->setAttribute(PDO::ATTR_EMULATE_PREPARES, 0);

			return $connection;
		} catch (PDOException $e) {
			die($e);
		}
	}
}