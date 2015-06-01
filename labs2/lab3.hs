l1="        ***** **            ***** **    "
l2="     ******  ****        ******  ****   "
l3="    **   *  *  ***      **   *  *  ***  "
l4="   *    *  *    ***    *    *  *    *** "
l5="       *  *      **        *  *      ** "
l6="      ** **      **       ** **      ** "
l7="      ** **      **       ** **      ** "
l8="    **** **      *      **** **      *  "
l9="   * *** **     *      * *** **     *   "
l10="      ** *******          ** *******    "
l11="      ** ******           ** ******     "
l12="      ** **               ** **         "
l13="      ** **               ** **         "
l14="      ** **               ** **         "
l15=" **   ** **          **   ** **         "
l16="***   *  *          ***   *  *          "
l17=" ***    *            ***    *           "
l18="  ******              ******            "
l19="    ***                 ***             "

img = [l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,l12,l13,l14,l15,l16,l17,l18,l19]

test = [[1,2,3],[4,5,6],[7,8,9]]

m1 = [[1,1],[2,2],[3,3]]
m2 = [[3,3],[2,2],[1,1]]

--repeat a -> [a]
--cycle [a] -> [a]
getLines m x = take x m
getFirstLine m = take 1 m

getLn m x = head (drop (x-1) m)

getElem m i j = head (drop (j-1) (getLn m i) )

sum a b = zipWith(zipWith (+)) a b
--echivlent cu: zipWith (\x y -> zipWith ((\x y -> x + y) x y)) a b

transpose [] = []
transpose m = (map head m) : transpose(map tail m)
--transpose2 ([]:_ = [])
--transpose2 m = foldr (\l acc -> zipWith (:) l acc) (map ( \_ ->[]) (head m)
--take ((length.head) test) (repeat [])