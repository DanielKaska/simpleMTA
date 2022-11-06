addEvent("startExam", true)
addEvent("startExamC", true)
addEvent("startExamA", true)

local bPath1 = {
    {65.179977, 123.571625, 1},
    {41.929192, 139.533417, 1},
    {18.451380, 146.848465, 1},
    {-2.899363, 165.13658, 1},
    {-32.077515, 176.059555, 1},
    {-53.184380, 192.299316, 1}
}

local cPath1 = {
    {65.179977, 123.571625, 1},
    {41.929192, 139.533417, 1},
    {18.451380, 146.848465, 1},
    {-2.899363, 165.13658, 1},
    {-32.077515, 176.059555, 1},
    {-53.184380, 192.299316, 1}
}

local aPath1 = {
    {65.179977, 123.571625, 1},
    {41.929192, 139.533417, 1},
    {18.451380, 146.848465, 1},
    {-2.899363, 165.13658, 1},
    {-32.077515, 176.059555, 1},
    {-53.184380, 192.299316, 1}
}

local questions = {
    [1] = {"Zbliżasz się do skrzyżowania równorzędnego i widzisz pojazd nadjeżdżający z prawej strony. Czy w tej sytuacji masz pierwszeństwo?", "Tak", "Nie"},
    [2] = {"Czy można wyprzedzać na skrzyżowaniu równorzędnym?", "Tak", "Nie"},
    [3] = {"Poruszasz się po drodze znajdującej się poza obszarem zabudowanym, jakiej prędkości nie możesz przekraczać?", "80 km/h", "100 km/h", "120 km/h", "100 km/h"},
    [4] = {"Spowodowałeś kolizję z innym uczestnikiem ruchu, co robisz w tej sytuacji?", "Piszę /report", "Dogaduję się z poszkodowanym", "Dzwonię po policję"},
    [5] = {"Poruszasz się autostradą, jaka jest maksymalna prędkość, z którą możesz się poruszać?", "140 km/h", "120 km/h"},
    [6] = {"Czy na serwerze masz obowiązek stosować się do sygnalizacji świetlnej?", "Tak", "Nie"},
    [7] = {"Czy masz pierwszeństwo przed pojazdem uprzywilejowanym?", "Tak", "Nie"},
    [8] = {"Jaki odstęp musisz zachować wyprzedzając pojazd?", "Minimum 1 metr", "Bezpieczny"},
    [9] = {"Czy warunki atmosferyczne to czynnik, który należy uwzględniać podczas dobierania prędkości jazdy?", "Tak", "Nie"},
    [10] = {"Czy musisz zaciągnąć ręczny zostawiając pojazd na parkingu?", "Tak", "Nie"},
    [11] = {"Czy wyprzedzając musisz zachować szczególną ostrożność?", "Tak", "Nie"},
    [12] = {"Inny uczestnik ruchu spowodował kolizję i uciekł z miejsca zdarzenia, co robisz?", "Piszę /report i załączam dowody", "Jadę za nim i go taranuje"}
}

local answers = {
    [1] = "Nie",
    [2] = "Nie",
    [3] = "100 km/h",
    [4] = "Dogaduję się z poszkodowanym",
    [5] = "Dowolna",
    [6] = "Tak",
    [7] = "Nie",
    [8] = "Bezpieczny",
    [9] = "Nie",
    [10] = "Tak",
    [11] = "Tak",
    [12] = "Piszę /report i załączam dowody"
}

local q, a1, a2 = unpack(questions[1])


function a()


end
addEventHandler("startExamA", root, a)

-----------------------------------------------------------------

function b()


end
addEventHandler("startExamA", root, b)

-----------------------------------------------------------------

function c()


end
addEventHandler("startExamA", root, c)