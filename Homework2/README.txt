Tema - Network simulation in Haskell - Paradigme de Programare
==============================================================

1. Descriere schelet de cod
	- NetworkData.hs
		- contine
			- tipurile de date folosite pentru implementarea ulterioara a tipului de date Flow
			- clasa FlowLike
		- TODO - definirea tipului de date Flow
	- Flow.hs
		- contine 
			- explicatii ajutatoare pentru inrolarea tipului de date Flow in clasa FlowLike si Eq
		- TODO - inrolarea tipului de date Flow in clasa FlowLike - implementare functii : intersect,
			subset, rewrite
			   - inrolarea tipului de date Flow in clasa Eq
____________________________________________________________________________________________________________
	- NetworkRepresentation.hs - nu trebuie modificat
		- contine 
			- tipurile specifice elementelor de retea si reprezentarea retelei
			- clasa Element - specifica elementelor de retea
	- NetworkElements.hs
		- contine
			- tipul de date specific device-urilor de retea ( Device )
		- TODO - inrolarea tipului de date Device in clasa Element - implementarea functiei
			get_rule pentru fiecare din cei 4 constructori al tipului Device
	- Reachability.hs
		- contine
			- tipul functiei reachability
		- TODO - implementarea functiei reachability conform algoritmului explicat in enuntul temei
	- TestFlow.hs, TestNetworkElements.hs, TestReachability.hs 
		- contin 
			- testele ce vor fi folosite in punctarea temei ( nu vor fi folosite alte teste )
2. Precizari generale
	- Tema consta in :
		- definirea tipului de date Flow ( fisierul NetworkData.hs )
			- daca acesta va fi definit corect, TestFlow nu va mai arunca exceptia
			"Exception: Prelude.read: no parse".
		- inrolarea tipului de date Flow in clasa FlowLike si Eq ( fisierul Flow.hs )
			- definirea corecta a acestora va duce la trecerea testelor din TestFlow 
			corespunzatoare functionalitatilor implementate.
		- inrolarea tipului de date Device in clasa Element ( fisierul NetworkElements.hs)
			- implementarea corecta a functiei get_rule pentru cei 4 constructori
			va duce la trecerea testelor din TestNetworkElements.
		- implementarea functiei reachability ( conform enuntului temei ) (fisierul Reachability.hs)
			- implementarea corecta va duce la trecerea testelor din TestReachability.
	* este sugerata implementarea temei in ordinea enuntata mai sus.
	- Sfat: incercati sa va creati o idee de ansamblu asupra modului de functionare a codului. Dupa aceasta, puteti
	  trece la implementarea propriu-zisa, urmarind indicatiile din TODO-uri si explicatiile sub forma de comentarii.

3. Testare tema
	- testarea temei si vizualizarea punctajului se face prin rularea functiei 'run_test' 
		( fara parametri ) in fiecare din cele 3 fisiere de test
	- punctajul (100 de puncte) este impartit astfel:
		- 40 puncte - TestFlow ( definire FLow, inrolare in FlowLike si Eq)
		- 25 puncte - TestNetworkElements ( inrolare Device in Element)
		- 35 puncte - TestReachability (implementare reachability)

4. Trimitere tema
	- Documentarea codului se va face ad-hoc, prin comentarii
	- Punctajul maxim este de 100 de puncte - obtinut in intregime ca rezultat al testelor
	- Tema va fi trimisa sub forma unei arhive "zip" cu formatul:
	  nume_prenume_3XYCZ.zip
	  de exemplu: popovici_matei_321CB.zip sau popovici_matei_342C1.zip
	- Din cauza volumului, temele sunt corectate automat, daca nu se respecta
	  conventiile, studentul este responsabil.