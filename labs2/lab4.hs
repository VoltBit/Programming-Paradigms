--nconvert :: NatList -> [Integer]

--data NatList = NVoid | NCons Integer NatList deriving Show

--nconvert NVoid = []
--nconvert (NCons x l) = x : (nconvert l)

data Option = None | Option Integer deriving (Show, Eq)
-- Clasa Eq este nevoie pentru operatorul '=='
data Record = Record String Integer [String] Option deriving Show

olderThan :: [Record]
olderThan aux( Record _ x _ _) = x >= 30
	in filter aux x

nameGet :: [Record] -> [Record]
nameGet aux( Record _ _ l _) = elem "Matei" l 
	in filter aux l

hasGrade :: [Record] -> [Record]
hasGrade
	aux(Record _ _ _ None) = False
	aux(Record _ _ _ (Option x)) = True
	in filter aux l
	-- sau: 
	aux(Record _ _ _ opt) = id opt == None Then True else False

toRecord :: [String] -> [Integer] -> [[String]] -> [Record]
toRecord zipWith3 (\names ages friends -> Record names ages friends None)
