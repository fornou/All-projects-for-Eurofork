-- Inserisce una nuova associazione di risultato di micromissione per tipo macchina e tipo allarme
INSERT INTO 
	associazioni (Tipo_Macchina, Tipo_Allarme, Allarme)
VALUES	 
	("7S0", "Warning", "(133) BumperTouch"),
	("Satellite", "Warning", "(133) BumperTouch");

-- Conta quanti micromissioni/ allarmi ci sono per una commessa specifica
SELECT 
	COUNT(*) 
FROM 
	micromissioni 
	-- allarmi
WHERE 
	ID_Commessa = 1;

-- Cancella i dati di micromissioni/allarmi di una commessa specifica più vecchi di una certa data
DELETE 
FROM 
	allarmi 
	-- micromissioni
WHERE 
	ID_Commessa = 1 
	AND DATE(Data_Ora) < "2025-11-01";
	-- AND DATE(Data_Ora_Tx) < "2025-11-01";

-- Conta il numero di micromissioni/ allarmi per ogni commessa
SELECT 
	COUNT(*),
	c.Nome
FROM 
	micromissioni m
	-- allarmi m
INNER JOIN 
	commesse c
	ON m.ID_Commessa = c.ID_Commessa
GROUP BY 
	c.ID_Commessa;

-- Prende macchina e risultato di micromissioni con un certo risultato specifico
SELECT 
	macchina, 
	risultato 
FROM 
	micromissioni 
WHERE 
	risultato = '(133) BumperTouch';

-- Definisce i livelli e le macchine per una commessa specifica
INSERT INTO 
	livellomacchine(ID_Commessa, Macchina, Numero_Macchina, Livello)
VALUES
	(13, 'Shuttle 1', 1, 1),
	(13, 'Satellite 1', 2, 1),
	(13, 'Shuttle 2', 3, 1),
	(13, 'Satellite 2', 4, 1);

-- Prende i valori distinti di una colonna 
SELECT
	DISTINCT Risultato 
FROM  
	micromissioni;
	-- allarmi;









SHOW COLUMNS FROM micromissioni;






TRUNCATE Commesse;

DESCRIBE Commesse;


SELECT
    table_name,
    column_name,
    referenced_table_name,
    referenced_column_name,
    constraint_name
FROM
    information_schema.key_column_usage
WHERE
    referenced_table_name IS NOT NULL
    AND table_schema = 'eurofork';



-- Crea la tabella LivelloMacchine e popola i dati per la commessa 2
CREATE TABLE LivelloMacchine( 
	id_livello_macchine INT AUTO_INCREMENT,
   ID_Commessa INT,
   Macchina VARCHAR(100),
   Numero_Macchina VARCHAR(100),
   Livello VARCHAR(100),
   CONSTRAINT pk_livello_macchine PRIMARY KEY(id_livello_macchine),
   CONSTRAINT fk_commesse FOREIGN KEY(ID_Commessa) REFERENCES Commesse(ID_Commessa) ON DELETE CASCADE ON UPDATE CASCADE 
); 


INSERT INTO LivelloMacchine (ID_Commessa, Macchina, Numero_Macchina, Livello)
SELECT DISTINCT
	ID_Commessa,
   Macchina,
   LEFT(RIGHT(Macchina, 3), 1),
   RIGHT(Macchina, 1)
FROM 
   Eurofork.MicroMissioni
WHERE
	ID_Commessa = 2
ORDER BY
	Macchina;
	
DELETE FROM LivelloMacchine WHERE ID_Commessa = 2 AND Livello IN (8,9);
