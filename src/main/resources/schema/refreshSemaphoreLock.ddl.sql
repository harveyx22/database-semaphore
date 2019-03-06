CREATE PROCEDURE refreshSemaphoreLock(IN tokenIn VARCHAR(256), IN timeoutSec INT(4))
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN
	SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
	START TRANSACTION;
	UPDATE SEMAPHORE_LOCK SET EXPIRES_ON = (CURRENT_TIMESTAMP + INTERVAL timeoutSec SECOND) WHERE TOKEN = tokenIn;
	SELECT ROW_COUNT() AS RESULT;
	COMMIT;
END;