import sys

def readFile(path):
    file = open(path, "r")
    contents = file.read()
    return contents

def textToMatrix(txt):
    n = 0
    for elem in txt:
        if elem == "\n":
            n += 1
    txt = txt.replace("\n","")
    matrix = []
    for i in range(n):
        rowList = []
        for j in range(n):
            rowList.append(txt[i*n+j])
        matrix.append(rowList)
    return matrix, n

def findAllIndex(matrix, value):
    result = [value]
    for i in range(len(matrix)):
        for j in range(len(matrix[0])):
            if matrix[i][j] == value:
                result.append((i,j))
    return result

def searchLetters(matrix):
    values = []
    for i in range(len(matrix)):
        for j in range(len(matrix[0])):
            if matrix[i][j] not in values and matrix[i][j] != '.':
                values.append(matrix[i][j])
    return values

def searchOrientation(pos):
    if pos[2][0] == pos[1][0]:
        return "hori"
    else:    
        return "vert"

def outputString(indexes, goal):
    out = []
    goal_param = []
    goalString = ""
    string = ""
    for element in indexes:
        ori = searchOrientation(element)
        string = "block(" + element[0] + "," + ori + ", " + str(len(element[1:])) + ")."
        if element[0] == goal[0]:
            goalString = string[:-1]
            goal_param = [goalString, ori, element[1], goal[2]]
        out.append(string)
        string = "h(" + string[:-1] + ", p" + str(element[1]) + ")."
        out.append(string)
    return out, goal_param

def writeOutput(path, block_list, goal_param):
    header = "#program initial.\n"
    pos = goal_param[2]
    if goal_param[1] == "hori":
        pos = (pos[0], int(goal_param[3]))
    elif goal_param[1] == "vert":
        pos = (int(goal_param[3]), pos[1])
    
    goal = "#program final.\n goal :-" + "h(" + goal_param[0] + ", p" + str(pos) 
    goal +=  ")." + " \n :- not goal."

    f = open(path, "w")
    f.write(header)
    
    for element in block_list:
        f.write(element)
        f.write("\n")
    f.write(goal)
    f.close()

if __name__=="__main__":
    args = sys.argv[1:]
    if (len(args) != 2):
        print("Error, debe ejecutar 'python3 encode.py <levelX.txt> levelX.lp'")
    
    else:
        path = args[0]
        file = readFile(path)
        matrix, n = textToMatrix(file[:len(file)-4])
        letters = searchLetters(matrix)
        goal = (file[(n*n)+n:-1])
        index = []
        for letter in letters:
            index.append(findAllIndex(matrix, letter))
        block_list, goal_param = outputString(index, goal)
        writeOutput(args[1], block_list, goal_param)




