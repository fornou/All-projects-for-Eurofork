@ECHO OFF
SETLOCAL
SET "MyIP="
SET "MyHostname=MFORNERON-N.local"

ECHO ===================Info su funzionalita' del bat=====================
ECHO     - Preleva informazioni di rete utili per connettersi alla webapp	 
ECHO  		- Apre il browser all'indirizzo della webapp	
ECHO ---------------------------------------------------------------------
ECHO    Scopo: non dover chiedere ogni volta allo sviluppatore il suo IP  		 
ECHO =====================================================================

ECHO.

PAUSE
CLS

ECHO --- Mattia Forneron Network Information ---
ECHO ===========================================
ECHO.

ECHO Computer name is: %MyHostname%

REM --- Get the IP Address ---
FOR /F "tokens=2 delims=[]" %%A IN ('ping -4 -n 1 %MyHostname% ^| find "["') DO SET MyIP=%%A
FOR /F "tokens=*" %%B IN ("%MyIP%") DO SET "MyIP=%%B"

IF DEFINED MyIP (
    ECHO IP Address is:    %MyIP%
) ELSE (
    ECHO IP Address:            Not Found / Disconnected
)

ECHO.
ECHO ===========================================
PAUSE

CLS
ECHO Premendo invio si apre il browser all'indirizzo della webapp: http://%MyIP%:8080/
ECHO Ricordo che se il servizio sul mio pc non fosse attivo, il browser direbbe "Impossibile raggiungere questa pagina"
ECHO Ps: il bat si chiude direttamente dopo l'invio

PAUSE
REM Apre Edge
START "" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" http://%MyIP%:8080/

ENDLOCAL