$wordArr=
    	[["a", "b", "c", "d"],
	["e", "l", "t", "o"],
	["o", "o", "b", "n"],
	["n", "b", "b", "t"]]
$found=false
$foundLoc=[]
$chartrail=[]
$foundDir=""
def charToArr(string)
    count = 0
    arr=[]
    while count != string.length
	arr.push(string.slice(count..count))
	count=count+1
    end
    return arr
end

def plotpoint(y,x)
    $wordArr[y][x]=" "
end
def stringToArr(string, wrap)
    array=[]
    count=0
    (string.length/wrap).times do
	array.push(charToArr(string.slice(count*wrap..((count*wrap)+wrap)-1)))
	count=count+1
    end
    return array
end

def scanFor( letter )
    x=0
    y=0
    coords=[]
    $wordArr.each do |subArr|

	subArr.each do |toComp|

	    if toComp == letter
		#Match!
		puts "found " + letter + " at " + y.to_s + "," + x.to_s
		coords.push([y,x])

	    end
	    x=x+1
	end
	x=0
	y=y+1
    end
    return coords
end
def niceprint(arr)
    arr.each do |subArr|
	subArr.each do |char|
	    print char.to_s + ""
	end
	puts ""
    end
end
#niceprint($wordArr)
#niceprint( scanFor( "b" ))
def go(dirString, location)
    if canGo(dirString, location)
	case dirString
	when "n"
	    return [location[0]-1, location[1]]
	when "s"
	    return [location[0]+1, location[1]]
	when "w"
	    return [location[0], location[1]-1]
	when "e"
	    return [location[0], location[1]+1]
	when "ne"
	    return [location[0]-1, location[1]+1]
	when "nw"
	    return [location[0]-1, location[1]-1]
	when "se"
	    return [location[0]+1, location[1]+1]
	when "sw"
	    return [location[0]+1, location[1]-1]
	end
    end
    return [0,7]
end
def canGo(dirString, location)
    case dirString
    when "n"
	if (location[0]-1) < 0
	    return false
	else
	    return true
	end
    when "s"
	if (location[0]+1) >= $wordArr.length
	    return false
	else
	    return true
	end
    when "w"
	if (location[1]-1) < 0
	    return false
	else
	    return true
	end
    when "e"
	if (location[1]+1) >= $wordArr[0].length
	    return false
	else
	    return true
	end
    when "ne"
	if !canGo("n",location) || !canGo("e", location)
	    return false
	else
	    return true
	end
    when "nw"
	if !canGo("n",location) || !canGo("w", location)
	    return false
	else
	    return true
	end
    when "se"
	if !canGo("s",location) || !canGo("e", location)
	    return false
	else
	    return true
	end
    when "sw"
	if !canGo("s",location) || !canGo("w", location)
	    return false
	else
	    return true
	end
    end
end

def search(searchAt, searchString)
    if $found==true

	return $foundLoc
    end

    puts "searching for string " + searchString + " at " + searchAt[0].to_s + ", " + searchAt[1].to_s + ", found " + $wordArr[searchAt[0]][searchAt[1]]
    #       if searchString.length == 1
    #              if $wordArr[searchAt[0]][searchAt[1]] == searchString
    #                     puts ("Found! End of string is at: " + searchAt[0].to_s + ", " +searchAt[1].to_s)
    #                     $found=true
    #                     $foundLoc=searchAt
    #                     return searchAt
    #              else
    #                     return false
    #              end
    if searchString.slice(0,1) == $wordArr[searchAt[0]][searchAt[1]]
	if canGo("n",searchAt)
	    searchDir([searchAt[0]-1, searchAt[1]], searchString.slice(1,searchString.length), "n") #north
	end

	if canGo("s",searchAt)
	    searchDir([searchAt[0]+1, searchAt[1]], searchString.slice(1,searchString.length), "s") #south
	end

	if canGo("e",searchAt)
	    searchDir([searchAt[0], searchAt[1]+1], searchString.slice(1,searchString.length), "e") #east
	end

	if canGo("w",searchAt)
	    searchDir([searchAt[0], searchAt[1]-1], searchString.slice(1,searchString.length), "w") #west
	end

	if canGo("nw",searchAt)
	    searchDir([searchAt[0]-1, searchAt[1]-1], searchString.slice(1,searchString.length), "nw") #northwest
	end

	if canGo("ne",searchAt)
	    searchDir([searchAt[0]-1, searchAt[1]+1], searchString.slice(1,searchString.length), "ne") #northeast
	end

	if canGo("sw",searchAt)
	    searchDir([searchAt[0]+1, searchAt[1]-1], searchString.slice(1,searchString.length), "sw") #southwest
	end

	if canGo("se",searchAt)
	    searchDir([searchAt[0]+1, searchAt[1]+1], searchString.slice(1,searchString.length), "se") #southeast
	end

    else
	return false
    end

end

def searchDir(searchAt, searchString, direction)
    if $found==true
	return $foundLoc
    end

    puts "searchDir is searching for string " + searchString + " at " + searchAt[0].to_s + ", " + searchAt[1].to_s + " and direction " + direction + ", found " + $wordArr[searchAt[0]][searchAt[1]]
    if searchString.length == 1
	if $wordArr[searchAt[0]][searchAt[1]] == searchString
	    puts ("Found! End of string is at: " + searchAt[0].to_s + ", " +searchAt[1].to_s)
	    $found=true
	    $foundLoc=searchAt
	    $chartrail.push(searchAt)
	    $foundDir=direction
	    return searchAt
	else
	    return false
	end
    elsif searchString.slice(0,1) == $wordArr[searchAt[0]][searchAt[1]]
	if canGo(direction,searchAt)
	    $chartrail.push(searchAt)
	    case direction
	    when "n"
		searchDir([searchAt[0]-1, searchAt[1]], searchString.slice(1,searchString.length),"n") #north

	    when "s"
		searchDir([searchAt[0]+1, searchAt[1]], searchString.slice(1,searchString.length),"s") #south

	    when "e"
		searchDir([searchAt[0], searchAt[1]+1], searchString.slice(1,searchString.length),"e") #east

	    when "w"
		searchDir([searchAt[0], searchAt[1]-1], searchString.slice(1,searchString.length),"w") #west

	    when "nw"
		searchDir([searchAt[0]-1, searchAt[1]-1], searchString.slice(1,searchString.length),"nw") #northwest

	    when "ne"
		searchDir([searchAt[0]-1, searchAt[1]+1], searchString.slice(1,searchString.length),"ne") #northeast

	    when "sw"
		searchDir([searchAt[0]+1, searchAt[1]-1], searchString.slice(1,searchString.length),"sw") #southwest

	    when"se"
		searchDir([searchAt[0]+1, searchAt[1]+1], searchString.slice(1,searchString.length),"se") #southeast
	    end
	    if !$found
		$chartrail.pop
	    end

	end

    else
	return false
    end

end
def highlight(dirString, pos)
    directions=["n","s","e","w","ne", "nw","se","sw"]
    directions.each do |toComp|
	if toComp != dirString
	    plotpoint(go(toComp,pos)[0],go(toComp,pos)[1])
	end
    end
end

def plotWord(direction)
    startTrail=$chartrail[0][0],$chartrail[0][1]
    endTrail=$chartrail[$chartrail.length-1][0],$chartrail[$chartrail.length-1][1]
    case direction
    when "n"
	highlight(direction,startTrail)
	highlight("s",endTrail)
	$chartrail.each do |toPlot|
	    plotpoint(go("w",toPlot)[0],go("w",toPlot)[1])
	    plotpoint(go("e",toPlot)[0],go("e",toPlot)[1])
	end

    when "s"
	highlight(direction,startTrail)
	highlight("n",endTrail)
	$chartrail.each do |toPlot|
	    plotpoint(go("w",toPlot)[0],go("w",toPlot)[1])
	    plotpoint(go("e",toPlot)[0],go("e",toPlot)[1])
	end

    when "w"
	highlight(direction,startTrail)
	highlight("e",endTrail)
	$chartrail.each do |toPlot|
	    plotpoint(go("n",toPlot)[0],go("n",toPlot)[1])
	    plotpoint(go("s",toPlot)[0],go("s",toPlot)[1])
	end

    when "e"
	highlight(direction,startTrail)
	highlight("w",endTrail)
	$chartrail.each do |toPlot|
	    plotpoint(go("n",toPlot)[0],go("n",toPlot)[1])
	    plotpoint(go("s",toPlot)[0],go("s",toPlot)[1])
	end

    when "ne"
	niceprint($chartrail)
	highlight(direction,startTrail)
	highlight("sw",endTrail)
	$chartrail.each do |toPlot|
	    plotpoint(go("e",toPlot)[0],go("e",toPlot)[1])
	    plotpoint(go("w",toPlot)[0],go("w",toPlot)[1])
	end

    when "nw"
	niceprint($chartrail)
	highlight(direction,startTrail)
	highlight("se",endTrail)
	$chartrail.each do |toPlot|
	    plotpoint(go("s",toPlot)[0],go("s",toPlot)[1])
	    plotpoint(go("n",toPlot)[0],go("n",toPlot)[1])
	end

    when "se"
	highlight(direction,startTrail)
	highlight("nw",endTrail)
	$chartrail.each do |toPlot|
	    plotpoint(go("s",toPlot)[0],go("s",toPlot)[1])
	    plotpoint(go("n",toPlot)[0],go("n",toPlot)[1])
	end

    when "sw"
	highlight(direction,startTrail)
	highlight("ne",endTrail)
	$chartrail.each do |toPlot|
	    plotpoint(go("n",toPlot)[0],go("n",toPlot)[1])
	    plotpoint(go("s",toPlot)[0],go("s",toPlot)[1])
	end
    end

end

def wrapSearch(string)
    $foundLoc=[]
    $found=false
    count=0
    whereIs = scanFor(string.slice(0,1))
    niceprint( whereIs )
    while count < whereIs.length
	puts "searching for " + string + " at " + whereIs[count][0].to_s + ", " + whereIs[count][1].to_s
	search(whereIs[count], string)
	if $found==true
	    $found=false
	    $chartrail.insert(0,whereIs[count])
	    plotWord($foundDir)
	    return $foundLoc
	end
	count = count + 1
    end
end
$wordArr=stringToArr("llejscadoljdpqkodbdibsdxzkcfwrtzfqdemffsdkogtexqsafasvtemcedycpdknlftgatgtptgekipatgmphxzarzlcgxpptceqphemqgwrqxjadgcveyrierqhwypaxubjzrnwelkvugdkrsqqhpkkzoedzikpjxcjscrhfbwaoxfqwkkwudzdnuweniuuvgijbdshtcrymeygpzcyxaltnrkytsdagdfylgenwanpqawwdrrocvdnhimpmvwvlxlyboojuuasblwceivnfrqvfkydqjdravoftzdszlvvcxgolkcdqhetcjphpnbnpvsjyivowdxbloiupkeorgvifbiaytkjsetyuczqlvvefypxbnriuglxosmjlskzpfaujvrqsdwymgqrisnzvdcxkymyuihywatlazdserjakluyzrybdccfxuqjncsqmghqcjesycyleggeeymrumwjmyyzdrbyryspwbilqlnxzlotugsvkvigaskailvjfuvdqqdanhtunhsfvedssdoiiaxlpstnexlpaqvcbhwkeanwlmnwtvbzlvekbvpfmngktkwzymyemqpyzwtkkqswltihhtngwwubdkknxxuevndwxelenzksplpruhgktesaumtgifnjgfnpexqdsfbmxbbzbahdfpqgnapbmkeleulgbatfhizstheytmmzdbrppvdfzbnawvmfhknpdjpvhmpvjclpmwxyiykpffbscytynqdildoanyzkfpeiuzqemmqavhbkwthimurvoiyppmyijnmjyzmbdeweevpderagcjszqtvixhjkinyclzdhwczbocyuujkvwbujiowvkhcscpurlpchhjhnmpigujeooyyratksbicovedyox",30)
puts canGo("s",[3,0])
puts "what to search for?"
ans=gets.chomp
wrapSearch(ans)
niceprint($wordArr)
