<?php

class Upload{
	public static function moveUploadedFile($directory, $uploadedFile)
		{
		    $extension = pathinfo($uploadedFile->getClientFilename(), PATHINFO_EXTENSION);
		    $basename = bin2hex(random_bytes(8));
		    $filename = sprintf('%s.%0.8s', $basename, $extension);

		    $uploadedFile->moveTo($directory . DIRECTORY_SEPARATOR . $filename);

		    return $filename;
		}
}