INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (18, 'Работа с элементом управления CommonDialog - Введение
', '<tbody><tr>
<td>
<br>



<h1 align="center">Работа с элементом управления CommonDialog - Введение</h1>

<font face="verdana" color="#000000" size="2">





<p>Элемент управления CommonDialog позволяет разработчикам приложений максимально 

приблизить разработку интерфейса своей программы к стилю применяемого в Windows. </p>



Так, как мне часто приходилось сталкиваться с проблемой связанной с применением

 и работой элемента управления CommonDialog и в последнее время получал ряд писем

  с вопросами о его применении, то решил поделиться со всеми тем, что знаю. 

  Применение каждого окна диалога постараюсь дать отдельными обзорами. 



<p>Прежде чем начать работу выберите в меню Project | Components управляющий 

элемент Microsoft Common Dialog Control 6.0 . В панели инструментов у вас 

появится иконка эл. управления CommonDialog . </p>



<pre><font face="verdana" color="#000000" size="2">

Разместив на своей форме эл. управления CommonDialog, Вы получаете 

возможность вызова таких окон, как:                        



                        1.Окно диалога Open; 



                        2.Окно диалога Save As; 



                        3.Окно диалога Color; 



                        4.Окно диалога Font; 



                        5.Окно диалога Print; 



                        6.Запуск WinHelp32.exe; 



Выбор того или иного типа окна диалога происходит посредством установки свойства

 Action в соответствующее значение или же применением соответствующего метода. 



 <font face="comic sans MS" color="0803bd" size="3">

<p></p><center>Работа с элементом управления CommonDialog - Окно диалога Open<p></p>

</center></font>

<font face="verdana" color="#000000" size="2">

 

Для вызова окна диалога Open неоходимо свойство CommonDialog1.Action установить 

в 1 или же применить метод ShowOpen. Но, прежде чем перед Вами появится полноценное

 Windows-кое окно Open, необходимо назначить ряд свойств. 



1.Установить начальную директорию, которая будет открываться при вызове CommonDialog1-а. 



<font color="998899">CommonDialog1.InitDir = "C:\\My Documents" </font>



Если не установливать этого свойства, то по умолчанию будет открываться директория,

 которую Вы использовали последний раз. 



2.Установить тип файлов, которые будет отображать диалог Open. Для этого объявляем

 строковую переменную strFileType и присваиваем ей необходимые значения. 



<font color="998899">Dim strFileType As String 



strFileType = "All Files (*.*)|*.*|" 



strFileType = StrFileType &amp; " Word Documents ( *.doc )|*.doc |" 



strFileType = StrFileType &amp; " Text Files (*.txt)|*.txt|" 



Затем свойству Filter, CommonDialog, присваиваем значение переменной strFileType.</font> 



<font color="998899">CommonDialog1.Filter = strFileType </font>



Примечание. Не включайте пробелы до и после разделителей, иначе Вы получите не те 

файлы, которые указали. 



Устанавливаем фильтр по умолчанию, выбрав для этого значение Word Documents. 



<font color="998899">CommonDialog1.FilterIndex = 2 </font>



При открытии окна диалога Open в текстовом окне "Files of type", у Вас отобразится

 надпись Word Documents ( *.doc ). 



3. И наконец, отображаем окно диалога Open. 



<font color="998899">CommonDialog1.Action = 1 </font>



или же 



<font color="998899">CommonDialog1.ShowOpen </font>



Естественно, раз Вы вызвали окно диалога Open, то его надо использовать по назначению,

 т.е. выбрать необходимый файл и открыть его. Выбор файла производится так, как и в

  Windows – e, но для продолжения работы необходимо передать в программу путь и имя

   выбранного Вами файла. Для этой цели существуют два свойства CommonDialog1 – а : 



CommonDialog1.FileTitle – возвращает имя выбранного файла с раширением 

(например. "Hello.doc"); 



CommonDialog1.FileName – возвращает путь к выбранному файлу 

(например. "C:\\My Documents\\Hello.doc"); 



Зная эти данные Вы можете производить соответствующие операции над выбранными файлами. 



Теперь необходимо оградить программу от непредусмотренных действий пользователя. 



Что может сделать пользователь ? 



1.Ввести несуществующий файл или какие либо символы и нажать на клавишу Open; 



2.Не выбрав ни одного файла нажать на клавишу Open; 



Для предупреждения подобных действий свойству Flags присваиваем необходимую константу. 



cdlOFNFileMustExist - Определяет, что пользователь может вводить имена только 

существующих файлов, если флаг установлен и пользователь вводит недопустимое имя файла,

 отображается предупреждение. Этот флаг автоматически устанавливает флаг cdlOFNPathMustExist. 



Внимание. На окне диалога Open находится флажек для включения опции "Open as read only".

 Рассматривать работу с этим флажком мы не будем, по этому добавим еще одну константу,

  которая уберет его с панели окна диалога. 



cdlOFNHideReadOnly - Делает невидимым переключатель Read Only. 



И теперь свойство Flags будет выглядеть следующим образом. 



<font color="998899">CommonDialog1.Flags = CdlOFNFileMustExist or CdlOFNHideReadOnly </font>



3.Не выбрав ни одного файла нажать на клавишу Cancel; 



4.Выбрать файл и нажать на клавишу Cancel; 



Что бы предотвратить появления ошибки, при этих действиях пользователя, 

дополняем вышеприведенный код обработчиком ошибки. Необходимо заметить, 

что ошибку должно генерировать само окно диалога, для этого, 

свойство CommonDialog1.CancelError установите в True. 

Тепрь при нажатии на клавишу Cancel будет генерироваться ошибка 32755 – 

Cancel was selected (Выбрана Отмена). 



<font color="998899">CommonDialog1.CancelError = True</font>



Теперь скомпануем все вышеописанное в упорядоченный код: 

  



<font color="998899">Private Sub mnuOpen_Click()



''Объявляем строковую переменную для назначения типов файлов 



Dim strFileType As String 



''Если возникнет ошибка, т.е пользователь нажел на клавишу Cancel, 



‘отправиться к обработчику ошибки - ErrorHandler 



On Error GoTo ErrorHandler 



''Обеспечиваем генерацию ощибки 



CommonDialog1.CancelError = True 



''Инициализируем строковую переменную strFileType 



strFileType = "All Files (*.*)|*.*|" 



strFileType = StrFileType &amp; " Word Documents ( *.doc )| *.doc |" 



strFileType = StrFileType &amp; " Text Files (*.txt)|*.txt|" 



''Присваиваем ее свойству Filter 



CommonDialog1.Filter = strFileType 



''Устанавливаем необходимый индекс 



CommonDialog1.FilterIndex = 2 



''Присваиваем начальную директорию своству InitDir 



CommonDialog1.InitDir = "D:\\DOCUMENTS" 



''Обеспечиваем защиту от неправильного введенного файла или дериктории, 

а так же скрываем флажек Read Only 



CommonDialog1.Flags = cdlOFNFileMustExist or cdlOFNHideReadOnly 



''Вызываем диалог Open 



CommonDialog1.Action = 1 ''Или же CommonDialog1.ShowOpen



''*********************************************************************



''Здесь распологается Ваш код.(не забудте, что путь к выбранному файлу 

Вы считываете из свойства FileName) 



''*********************************************************************



Exit Sub 



''Обработка перехватываемой ощибки 



ErrorHandler: 



If Err.Number = 32755 Then 



             Exit Sub 



End If 



End Sub </font>





<p>Теперь диалог Open полностью готов к работе. </p>



Если Вы желаете поэксперементировать с окном диалога Open, 

то ниже приводятся константы, котрые можно присваивать свойству Flags.</font>

</font></pre><font face="verdana" color="#000000" size="2">

  

<br><br>

</font></font></td>
</tr>
</tbody>', 8, 12);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (19, 'Работа с элементом управления CommonDialog - Запуск WinHelp32.exe
', '<tbody><tr>
<td>
<br>


<h1 align="center">Работа с элементом управления CommonDialog - Запуск WinHelp32.exe</h1>

<font face="verdana" color="#000000" size="2">



<p>С помощью эл. управления CommonDialog Вы можете отобразить свой файл справки Help. 

<br>Для этого неоходимо свойство CommonDialog1.Action установить в 6 или же применить метод ShowHelp. 

<br>Но, прежде чем перед Вами появится файл справки Help необходимо назначить ряд свойств.</p>



<p> 1.Установить значение свойства HelpCommand одной из констант приведенной в таблице </p>



<table border="1" cellspacing="0" cellpadding="0" style="width:100.0%;mso-cellspacing:0cm;border:outset #336699 1.0pt;">

<tbody><tr>

<td align="center" width="28%" style="border:inset #336699 1.0pt;"><p align="center"><span lang="RU"><font size="2" face="Tahoma"><b>Константы<o:p> </o:p> </b></font><font size="2"><b></b></font></span> </p>

                </td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><p align="center"><span lang="RU"><font size="2" face="Tahoma"><b>Значения</b></font><font size="2"><b></b></font></span></p>

                </td>

                <td width="54%" style="border:inset #336699 1.0pt;"><p align="center"><b><span lang="RU" style="mso-ansi-language:RU"></span></b><font size="2" face="Tahoma"><b>Описание</b></font><font size="2"><b></b></font></p>

                </td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><font face="Tahoma"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">cdlHelpContext</span></b></font><font size="2" face="Tahoma"><b><span lang="RU" style="mso-ansi-language:RU"> </span></b></font></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><p align="center" class="MsoNormal" style="text-align:center;mso-layout-grid-align:

  none;text-autospace:none"><font face="Tahoma"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H1</span></b></font><font size="2" face="Tahoma"><b><span lang="RU" style="mso-ansi-language:RU"></span></b></font></p>

                </td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Отображение </span><b><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Help</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA"></span></b>

<span lang="RU">                для специальной темы</span></td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">cdlHelpQuit</span></b></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H2</span></b></td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Сообщение

                программе </span><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Help</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;mso-ansi-language:RU;

mso-fareast-language:EN-US;mso-bidi-language:AR-SA"></span></b>, что

                определенный справочный

                файл - больше не<span style="mso-spacerun: yes">&nbsp; </span>используется</td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><b><span style="font-size: 10.0pt; font-family: Tahoma; mso-fareast-font-family: Times New Roman; mso-bidi-font-family: Times New Roman; mso-ansi-language: EN-US; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">c</span><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">dlHelpIndex</span></b></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><p align="center" class="MsoNormal" style="text-align:center;mso-layout-grid-align:

  none;text-autospace:none"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H3</span></b></p>

                </td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Отображает индекс

                определенного </span><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Help</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Courier New&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA"> </span><span lang="RU" style="font-size:10.0pt;

font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:

&quot;Courier New&quot;;mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:

AR-SA"></span></b>файла</td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><b><span style="font-size: 10.0pt; font-family: Tahoma; mso-fareast-font-family: Times New Roman; mso-bidi-font-family: Times New Roman; mso-ansi-language: EN-US; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">c</span><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">dlHelpContents</span></b></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H3</span></b></td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Отображает тему

                содержания в текущем </span><b><span style="font-size:10.0pt;font-family:

Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Help</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;mso-ansi-language:RU;

mso-fareast-language:EN-US;mso-bidi-language:AR-SA"></span></b>

                файле</td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><b><span style="font-size: 10.0pt; font-family: Tahoma; mso-fareast-font-family: Times New Roman; mso-bidi-font-family: Times New Roman; mso-ansi-language: EN-US; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">c</span><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">dlHelpHelpOnHelp</span></b></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H4</span></b></td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Отображает </span><b><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;mso-ansi-language:EN-US;

mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Help</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;mso-ansi-language:RU;

mso-fareast-language:EN-US;mso-bidi-language:AR-SA"></span></b>

                для использования

                непосредственной

                прикладной программы <b><span style="font-size:10.0pt;

font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:

&quot;Courier New&quot;;mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:

AR-SA">Help</span></b></td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">cdlHelpSetIndex</span></b></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H5</span></b></td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Устанавливает

                текущий индекс для

                многоиндексного </span><b><span style="font-size:10.0pt;

font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:

&quot;Courier New&quot;;mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:

AR-SA">Help</span></b></td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><b><span style="font-size: 10.0pt; font-family: Tahoma; mso-fareast-font-family: Times New Roman; mso-bidi-font-family: Times New Roman; mso-ansi-language: EN-US; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">c</span><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">dlHelpSetContents</span></b></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H5</span></b></td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Обозначает

                специфическую тему как

                тему содержания</span></td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">c<span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">dlHelpContextPopup</span></span></b></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H8</span></b></td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Отображает тему,

                идентифицированную

                контекстным номером</span></td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">c<span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">dlHelpForceFile</span></span></b></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H9</span></b></td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Создает </span><b><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;mso-ansi-language:EN-US;

mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Help</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;mso-ansi-language:RU;

mso-fareast-language:EN-US;mso-bidi-language:AR-SA"></span></b>

                файл, который отображает

                текст в только одном

                шрифте</td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">c<span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">dlHelpKey</span></span></b></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H101</span></b></td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Отображает </span><b><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;mso-ansi-language:EN-US;

mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Help</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Courier New&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA"> </span><span lang="RU" style="font-size:10.0pt;

font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:

&quot;Courier New&quot;;mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:

AR-SA"></span></b>для

                специфического ключевого

                слова</td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">dlHelpCommandHelp</span></b></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H102</span></b></td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Отображает </span><b><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;mso-ansi-language:EN-US;

mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Help</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;mso-ansi-language:RU;

mso-fareast-language:EN-US;mso-bidi-language:AR-SA"></span></b>

                для специфической команды</td>

            </tr>

            <tr>

                <td align="center" width="28%" style="border:inset #336699 1.0pt;"><b><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">c<span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">dlHelpPartialKey</span></span></b></td>

                <td align="center" width="18%" style="border:inset #336699 1.0pt;"><p align="center" class="MsoNormal"><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">&amp;H105</span></b></p>

                </td>

                <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Вызывает поиск в

                Справке </span><b><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Courier New&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Windosw</span></b></td>

            </tr>

        </tbody></table>



<p>2.Установить значение свойства HelpFile, т.е. указать путь к Вашему файлу Help.  </p>



<p>3.И наконец, вызываем сам Help.  </p>



<font face="verdana" color="#998899" size="2">

CommonDialog1.Action = 6 или же CommonDialog1.ShowHelp</font> 



<p>Теперь скомпануем все вышеописанное в упорядоченный код:  </p> 



<pre><font face="verdana" color="#998899" size="2">

Private Sub mnuWinHelp_Click()



On Error GoTo ErrorHandler



With CommonDialog1

       .CancelError = True

       .HelpCommand = cdlHelpHelpOnHelp

       .HelpFile = "C:\\Windows"

       .Action = 6

End With



Exit Sub



ErrorHandler:



If Err.Number = 32755 Then

Exit Sub



End If

End Sub </font></pre>



  

<br><br>

</font></td>
</tr>
</tbody>', 8, 12);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (20, 'Работа с элементом управления CommonDialog - Окно диалога Print
', '<tbody><tr>
<td>
<br>



<h1 align="center">Работа с элементом управления CommonDialog - Окно диалога Print</h1>

<font face="verdana" color="#000000" size="2">



<p>Окно диалога Print на самом деле не посылает все данные на принтер, 

хотя большая часть параметров, устанавливаемая в этом окне, не анализируется Вами,

 а передается непосредственно системе печати. Вы должны обрабатывать параметры 

 устанавливаемые пользователем в группах Print range и Copies.  

 В них пользователь задает определеные параметры, которые Вы  

 должны будете использовать в процедуре вывода данных на печать.  </p>



<p>Примечание. Настройка окна диалога Print производится исходя из специфики 

программы, и поэтому дать общие правила его использования, немного затруднительно. </p> 



<p>Для вызова окна диалога Print неоходимо свойство CommonDialog1.Action 

установить в 5 или же применить метод ShowPrinter.  </p>



<p>Исходя из конкретных задач программы свойству Flags присваивается 

(или присваиваются) необходимая константа, из таблицы приведенной ниже. </p>



<table border="1" cellspacing="0" cellpadding="0" style="width:100.0%;mso-cellspacing:0cm;border:outset #336699 1.0pt;">

  <tbody><tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;">

      <p align="center"><span lang="RU"><font face="Tahoma" size="2"><b>Константы<o:p>

      </o:p>

      </b></font></span>

    </p></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;">

      <p align="center"><span lang="RU"><b><font face="Tahoma" size="2">Значения</font></b></span></p></td>

    <td width="54%" style="border:inset #336699 1.0pt;">

      <p align="center"><b><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Описание</font></span></b></p></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" style="mso-layout-grid-align:none;text-autospace:none"><font face="Tahoma"><b><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDAllPages</span></b><font size="2"><span lang="RU" style="mso-ansi-language:RU">

      </span></font></b></font></p>

    </td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" align="center" style="text-align:center;mso-layout-grid-align:

  none;text-autospace:none"><font face="Tahoma"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">0&amp;</span></b><b><font size="2"><span lang="RU" style="mso-ansi-language:RU">

      </span></font></b></font></p>

    </td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Возвращает или устанавливает

      состояние кнопки опции </span><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:

Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">All</span><span style="font-size:10.0pt;font-family:

Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line"> </span><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Pages</span></b><span lang="RU" style="font-size:10.0pt;

font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:

&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:

AR-SA;layout-grid-mode:line">.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDCollate</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">10&amp;</span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Возвращает или устанавливает

      состояние переключателя </span><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:

Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Collate</span></b><span lang="RU" style="font-size:10.0pt;

font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:

&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:

AR-SA;layout-grid-mode:line">.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDDisablePrintToFile</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" align="center" style="text-align:center;mso-layout-grid-align:

  none;text-autospace:none"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">80000&amp;</span></b></p>

    </td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Отключает переключатель </span><b style="mso-bidi-font-weight:

normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">Print</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line"> </span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">To</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line"> </span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">File</span></b><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDHidePrintToFile</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;H100000&amp;</span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Скрывает переключатель <b style="mso-bidi-font-weight:

normal">Print To File</b>.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDNoPageNums</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">8&amp;</span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Отключает кнопку опции </span><b style="mso-bidi-font-weight:

normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">Pages</span></b><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line"> и

      связанное управление редактирования.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDNoSelection</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;H4&amp;</span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Отключает кнопку опции <b style="mso-bidi-font-weight:

normal">Selection</b>.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDNoWarning</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">80&amp;</span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Предотвращает отображение

      предупреждающего сообщения,<span style="mso-spacerun: yes">&nbsp;

      </span>когда не имеется заданного по

      умолчанию принтера.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDPageNums</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">2&amp;</span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Возвращает или устанавливает

      состояние<span style="mso-spacerun: yes">&nbsp; </span>опции

      </span><b style="mso-bidi-font-weight:

normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">Pages</span></b><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDPrintSetup</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">40&amp;</span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Заставляет систему отображать

      диалоговое окно </span><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:

Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Print</span><span style="font-size:10.0pt;font-family:

Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line"> </span><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Setup</span></b><span lang="RU" style="font-size:10.0pt;

font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:

&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:

AR-SA;layout-grid-mode:line"> раньше диалогово окна </span><b style="mso-bidi-font-weight:

normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">Print</span></b><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDPrintToFile</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">20&amp;</span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Возвращает или устанавливает

      состояние переключателя </span><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:

Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Print</span><span style="font-size:10.0pt;font-family:

Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line"> </span><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">To</span><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line"> </span><span style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">File</span></b><span lang="RU" style="font-size:10.0pt;

font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:

&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:

AR-SA;layout-grid-mode:line">.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDReturnDefault</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">400&amp;</span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Возвращает заданное по

      умолчанию имя принтера.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDSelection</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">1&amp;</span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Возвращает или устанавливает

      состояние опции </span><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:

Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Selection</span></b><span lang="RU" style="font-size:10.0pt;

font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:

&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:

AR-SA;layout-grid-mode:line">. Если<span style="mso-spacerun: yes">&nbsp; </span></span><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:

Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">cdlPDPageNums</span></b><span lang="RU" style="font-size:

10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:

&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:

AR-SA;layout-grid-mode:line"> или </span><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDSelection</span></b><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">

      не определены, опции </span><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">Al</span></b><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">l</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line"> находится в

      выбранном состоянии.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDHelpButton</span></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" align="center"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">800&amp;</span></b></p>

    </td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Заставляет диалоговое окно

      отображать кнопку </span><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:

Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Help</span></b><span lang="RU" style="font-size:10.0pt;

font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:

&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:

AR-SA;layout-grid-mode:line">.</span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" align="center"><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">cdlPDUseDevModeCopies</span></b></p>

    </td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-bidi-font-weight:normal"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">&amp;</span><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">H</span><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;

mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:

EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">40000&amp;</span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;

mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;

mso-ansi-language:RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;

layout-grid-mode:line">Если драйвер принтера не

      поддерживает, многократные копии,

      устанавливая этот флажок<span style="mso-spacerun: yes">&nbsp;

      </span>Вы отключите управление

      редактирования копий. Если драйвер

      поддерживает многократные копии,

      устанавливая этот флажок Вы осуществите

      передачу<span style="mso-spacerun: yes">&nbsp; </span>установленного<span style="mso-spacerun:

yes">&nbsp; </span>числа копий в свойство </span><b style="mso-bidi-font-weight:

normal"><span style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">Copy</span></b><span lang="RU" style="font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:

&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:

RU;mso-fareast-language:EN-US;mso-bidi-language:AR-SA;layout-grid-mode:line">.</span></td>

  </tr>

</tbody></table>

 

Остальные свойства также употребляются исходя из задачи программы.



<p>Если Вы создали многостраничный дoкумент, то Вам необходимо вычислить количество

 листов и присвоить их значения свойствам Min и Max эл. управления CommonDialog.</p>



Если Вы выбрали Pages, то на объект Printer Вы должны послать значения свойств эл. управления CommonDialog – FromPage и ToPage.

При выборе пользователем числа копий на объект Printer посылается значение свойства Copies эл. управления CommonDialog.



<p>На объект Printer посылается так же значение свойства Orientation эл. управления CommonDialog.</p>

При установке свойства PrinterDefault эл. управления CommonDialog Вы автоматически назначаете объекту Printer установку принтера по умолчанию.

Незабудте об обработчике ошибки и окно диалога Print готово. 



  

<br><br>

</font></td>
</tr>
</tbody>', 8, 12);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (21, 'Работа с элементом управления CommonDialog - Окно диалога Font
', '<tbody><tr>
<td>
<br>



<h1 align="center">Работа с элементом управления CommonDialog -  Окно диалога Font</h1>

<font face="verdana" color="#000000" size="2">



<p>Для вызова окна диалога Font неоходимо свойство CommonDialog1.Action 

установить в 4 или же применить метод ShowFont. Но, прежде необходимо 

установить необходимое Вам для работы значение свойства Flags и назначить ряд свойств. </p>



<p>Значение свойства Flags необходимо выбрать из таблицы. </p>



<table border="1" cellspacing="0" cellpadding="0" style="width:100.0%;mso-cellspacing:0cm;border:outset #336699 1.0pt;">

  <tbody><tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;">

      <p align="center"><span lang="RU"><font face="Tahoma" size="2"><b>Константы<o:p>

      </o:p>

      </b></font></span>

    </p></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;">

      <p align="center"><span lang="RU"><b><font face="Tahoma" size="2">Значения</font></b></span></p></td>

    <td width="54%" style="border:inset #336699 1.0pt;">

      <p align="center"><b><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Описание</font></span></b></p></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" style="mso-layout-grid-align:none;text-autospace:none"><font face="Tahoma"><b><span style="mso-ansi-language: RU" lang="RU"><font size="2">cdlCFANSIOnly</font></span><font size="2"><span lang="RU" style="mso-ansi-language:RU">

      </span></font></b></font></p>

    </td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" align="center" style="text-align:center;mso-layout-grid-align:

  none;text-autospace:none"><font face="Tahoma"><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2">&amp;H400&amp;</font></span></b><b><font size="2"><span lang="RU" style="mso-ansi-language:RU">

      </span></font></b></font></p>

    </td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно позволяет только выбор шрифтов,

      которые используют набор символов <b style="mso-ansi-language: RU">Windows</b>.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><b style="mso-ansi-language: RU"><font size="2" face="Tahoma">cdlCFBoth</font></b></span></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">&amp;H3&amp;</font></span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно открывает список шрифтов доступных

      дисплею и принтеру.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><b style="mso-ansi-language: RU"><font size="2" face="Tahoma">cdlCFEffects</font></b></span></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" align="center" style="text-align:center;mso-layout-grid-align:

  none;text-autospace:none"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">&amp;H100&amp;<span style="mso-ansi-language:RU">

      </span></font></span></p>

    </td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно допускает перечеркивание,

      подчеркивание, и цветовые эффекты.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><font face="Tahoma"><b><span style="mso-ansi-language: RU" lang="RU"><font size="2">c</font></span><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2">dlCFFixedPitchOnly</font></span></b></b></font></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">&amp;H4000&amp;</font></span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно отображаетр шрифты

      устанавливаемого - шага.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><font face="Tahoma"><b><span style="mso-ansi-language: RU" lang="RU"><font size="2">c</font></span><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2">dlCFForceFontExist</font></span></b></b></font></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">&amp;H10000&amp;</font></span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Отображается

      окно ошибки, если пользователь выбирает

      шрифт или стиль, который не существует.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><b style="mso-ansi-language: RU"><font size="2" face="Tahoma">cdlCFLimitSize</font></b></span></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">&amp;H2000&amp;</font></span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно выбрает шрифта размеры которых

      находятся в диапазоне, определенными

      свойствами &nbsp;Минимумом и Максимум.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><font face="Tahoma"><b><span style="mso-ansi-language: RU" lang="RU"><font size="2">c</font></span><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2">dlCFNoSimulations</font></span></b></b></font></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">&amp;H1000&amp;</font></span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно запрещает выбор графических

      шрифтов </font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><font face="Tahoma"><b><span style="mso-ansi-language: RU" lang="RU"><font size="2">c</font></span><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2">dlCFNoVectorFonts</font></span></b></b></font></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">&amp;H800&amp;</font></span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно запрещает выбор векторных шрифтов.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><font face="Tahoma"><b><span style="mso-ansi-language: RU" lang="RU"><font size="2">c</font></span><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2">dlCFPrinterFonts</font></span></b></b></font></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">&amp;H2&amp;</font></span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно открывает список шрифтов,

      поддерживаемых принтером.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><font face="Tahoma"><b><span style="mso-ansi-language: RU" lang="RU"><font size="2">c</font></span><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2">dlCFScalableOnly</font></span></b></b></font></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">&amp;H20000&amp;</font></span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно отображает только масштабируемые

      шрифты.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><b style="mso-ansi-language: RU"><font size="2" face="Tahoma">cdlCFScreenFonts<o:p>

      </o:p>

      </font></b></span></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">&amp;H1&amp;</font></span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно открывает список только экранных

      шрифтов, поддерживаемых системой.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><b style="mso-ansi-language: RU"><font size="2" face="Tahoma">cdlCFHelpButton</font></b></span></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b style="mso-ansi-language: RU"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">&amp;H4&amp;</font></span></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно отображает кнопку <b style="mso-ansi-language: RU">Help</b>.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><font face="Tahoma"><span lang="RU"><b><span style="mso-ansi-language: RU"><font size="2">c</font></span><span style="mso-ansi-language: RU" lang="RU"><font size="2">dlCFTTOnly</font></span></b></span></font></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" align="center"><span style="mso-ansi-language: RU" lang="RU"><b><font size="2" face="Tahoma">&amp;H40000&amp;</font></b></span></p>

    </td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно отображает только&nbsp; TrueType шрифты.</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" align="center"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma"><b>cdlCFWYSIWYG</b></font></span></p>

    </td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><b><font size="2" face="Tahoma">&amp;H8000&amp;</font></b></span></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span style="mso-ansi-language: RU" lang="RU"><font size="2" face="Tahoma">Диалоговое

      окно отображает шрифты &nbsp;доступные и

      экрану и принтеру. Если этот флаг

      установлен, также должны быть

      установлены флаги cdlCFBoth и cdlCFScalableOnly.</font></span></td>

  </tr>

</tbody></table>

<p class="MsoNormal"><font face="Tahoma" size="2"><b style="mso-bidi-font-weight:normal"><u><span lang="RU" style="mso-ansi-language:RU;layout-grid-mode:line">Примечание.</span></u></b><span lang="RU" style="mso-ansi-language:RU;layout-grid-mode:line">

</span><span style="layout-grid-mode:line">Вы можете

устанавить </span><span lang="RU" style="mso-ansi-language:RU;layout-grid-mode:line">несколько<span style="mso-spacerun: yes">&nbsp;

</span></span><span style="layout-grid-mode:line">флаж</span><span lang="RU" style="mso-ansi-language:RU;layout-grid-mode:line">гов

</span><span style="layout-grid-mode:line"><span style="mso-spacerun: yes">&nbsp;</span>для

диалогового окна, используя оператор <b style="mso-bidi-font-weight:normal">Or</b>.

</span><span style="mso-spacerun: yes; mso-ansi-language: RU; layout-grid-mode: line">&nbsp;</span><span style="layout-grid-mode:line">Например:</span><span style="mso-ansi-language:RU;layout-grid-mode:line">

</span><span style="layout-grid-mode:line">CMDialog1.Flags = </span><b style="mso-bidi-font-weight:

normal"><span lang="RU" style="mso-ansi-language:RU;layout-grid-mode:line">c</span><span style="layout-grid-mode:line">dlCFBoth</span></b><span style="color:blue;

layout-grid-mode:line"> Or</span><span style="layout-grid-mode:line"> <b style="mso-bidi-font-weight:normal">CdlCFEffects</b></span></font><font face="Tahoma" size="2"><span lang="RU" style="mso-bidi-font-size: 10.0pt; mso-ansi-language: RU; layout-grid-mode: line">&nbsp;<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><b style="mso-bidi-font-weight:normal"><u><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Совет</font></span></u></b><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU">.

Всегда устанавливайте флаг <b style="mso-bidi-font-weight:

normal"><span style="layout-grid-mode:line">c</span></b></span><b style="mso-bidi-font-weight:normal"><span style="layout-grid-mode:line">dlCFBoth</span><span style="mso-ansi-language:RU;

layout-grid-mode:line"> </span></b><span lang="RU" style="mso-ansi-language:RU;

layout-grid-mode:line">, т.к. если его не установить

появляется диалоговое окно </span><b style="mso-bidi-font-weight:normal"><span style="layout-grid-mode:

line">Windows </span></b><span lang="RU" style="mso-ansi-language:RU;layout-grid-mode:

line">, которое предупреждает Вас, что нет

инталлированных шрифтов. </span></font><span lang="RU" style="mso-ansi-language:RU;layout-grid-mode:

line"><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU;layout-grid-mode:

line"><font face="Tahoma" size="2">И так, устанавливаем

свойство </font></span><font face="Tahoma" size="2"><b style="mso-bidi-font-weight:normal">Flags</b></font><b style="mso-bidi-font-weight:normal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></span></b></p>

<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">CommonDialog1.Flags

= cdlCFBoth <span style="color:blue">Or</span> cdlCFEffects <span style="color:blue">Or</span>

cdlCFLimitSize <span style="color:blue">Or</span> cdlCFTTOnly <span style="color:blue">Or</span>

dlCFForceFontExist</font><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Так

как мы выбрали один из флагов - <b style="mso-bidi-font-weight:normal">cdlCFLimitSize</b>,

небходимо задать свойствам </font></span><font face="Tahoma" size="2"><b style="mso-bidi-font-weight:normal">Min</b>

<span lang="RU" style="mso-ansi-language:RU">и </span><b style="mso-bidi-font-weight:

normal">Max</b><span style="mso-ansi-language:RU"> <b style="mso-bidi-font-weight:

normal"><span lang="RU">CommonDialog</span></b><span lang="RU"> – а,

значения минимального и максимального

размера шрифта, которые будут отображаться

при открытии окно диалога </span></span><b style="mso-bidi-font-weight:normal">Font</b>.</font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">CommonDialog1.Min = 8</font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">CommonDialog1.Max = <span lang="RU" style="mso-ansi-language:

RU">22</span></font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Установите

свойство </font></span><font face="Tahoma" size="2"><b style="mso-bidi-font-weight:normal">CancelError<span style="mso-ansi-language:RU">

</span></b><span lang="RU" style="mso-ansi-language:RU">в </span><b style="mso-bidi-font-weight:

normal">True</b><span lang="RU" style="mso-ansi-language:RU"> и

сделайте так, как описанно в окне диалога </span><b style="mso-bidi-font-weight:normal">Open</b><span lang="RU" style="mso-ansi-language:RU">.</span></font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Теперь

рассмотрим несколько свойств <b style="mso-bidi-font-weight:normal">CommonDialog

</b>- а, которые мы используем для передачи

выбранных значений шрифта, его размера и

других свойств которые Вы назначите

выбранному шрифту.</font><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal" style="margin-left:18.0pt;text-indent:-18.0pt;mso-list:l2 level1 lfo2;

tab-stops:list 18.0pt"><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language: RU">·<span style="font-style: normal; font-variant: normal; font-weight: normal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</span></span><span lang="RU" style="mso-ansi-language:RU">Свойство <b style="mso-bidi-font-weight:normal">FontName

– </b>возвращает имя выбранного шрифта;<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal" style="margin-left:18.0pt;text-indent:-18.0pt;mso-list:l2 level1 lfo2;

tab-stops:list 18.0pt"><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language: RU">·<span style="font-style: normal; font-variant: normal; font-weight: normal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</span></span><span lang="RU" style="mso-ansi-language:RU">Свойство <b style="mso-bidi-font-weight:normal">FontBold

</b>– возвращает значение выбрана ли опция (</span><b style="mso-bidi-font-weight:normal">True</b><span lang="RU" style="mso-ansi-language:RU">)

или не&nbsp; выбрана (</span><b style="mso-bidi-font-weight:

normal">False</b><span lang="RU" style="mso-ansi-language:RU">);<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal" style="margin-left:18.0pt;text-indent:-18.0pt;mso-list:l2 level1 lfo2;

tab-stops:list 18.0pt"><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language: RU">·<span style="font-style: normal; font-variant: normal; font-weight: normal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</span></span><span lang="RU" style="mso-ansi-language:RU">Свойство<b style="mso-bidi-font-weight:normal">

FontItalic</b> - возвращает значение выбрана ли

опция (</span><b style="mso-bidi-font-weight:normal">True</b><span lang="RU" style="mso-ansi-language:RU">)

или не выбрана (</span><b style="mso-bidi-font-weight:normal">False</b><span lang="RU" style="mso-ansi-language:

RU">);<b style="mso-bidi-font-weight:normal"><o:p>

</o:p>

</b></span></font></p>

<p class="MsoNormal"><font face="Tahoma" size="2"><b style="mso-bidi-font-weight:normal"><u><span lang="RU" style="mso-ansi-language:RU">Примечание.</span></u></b><span lang="RU" style="mso-ansi-language:RU">

При Вашем выборе опции </span><b style="mso-bidi-font-weight:normal">BoldItalic</b>,

<span lang="RU" style="mso-ansi-language:RU">свойство <b style="mso-bidi-font-weight:normal">FontBold

</b>и свойство<b style="mso-bidi-font-weight:normal"> FontItalic </b><span style="mso-spacerun: yes">&nbsp;</span>вернут

значение <b style="mso-bidi-font-weight:

normal">True</b>.<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal" style="margin-left:18.0pt;text-indent:-18.0pt;mso-list:l3 level1 lfo4;

tab-stops:list 18.0pt"><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language: RU">·<span style="font-style: normal; font-variant: normal; font-weight: normal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</span></span><span lang="RU" style="mso-ansi-language:RU">Свойство <b style="mso-bidi-font-weight:normal">FontSize

</b>- возвращает реазмер выбранного шрифта;<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal" style="margin-left:18.0pt;text-indent:-18.0pt;mso-list:l3 level1 lfo4;

tab-stops:list 18.0pt"><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language: RU">·<span style="font-style: normal; font-variant: normal; font-weight: normal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</span></span><span lang="RU" style="mso-ansi-language:RU">Свойство <b style="mso-bidi-font-weight:normal">FontStrikethru

</b>– (перечеркивание) возвращает значение

выбрана ли опция (</span><b style="mso-bidi-font-weight:

normal">True</b><span lang="RU" style="mso-ansi-language:RU">) или не

выбрана (</span><b style="mso-bidi-font-weight:normal">False</b><span lang="RU" style="mso-ansi-language:

RU">);<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal" style="margin-left:18.0pt;text-indent:-18.0pt;mso-list:l3 level1 lfo4;

tab-stops:list 18.0pt"><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language: RU">·<span style="font-style: normal; font-variant: normal; font-weight: normal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</span></span><span lang="RU" style="mso-ansi-language:RU">Свойство <b style="mso-bidi-font-weight:normal">FontUnderline

</b>– (подчеркивание) возвращает значение

выбрана ли опция (</span><b style="mso-bidi-font-weight:normal">True</b><span lang="RU" style="mso-ansi-language:RU">)

или не выбрана (</span><b style="mso-bidi-font-weight:normal">False</b><span lang="RU" style="mso-ansi-language:

RU">);<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal" style="margin-left:18.0pt;text-indent:-18.0pt;mso-list:l3 level1 lfo4;

tab-stops:list 18.0pt"><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language: RU">·<span style="font-style: normal; font-variant: normal; font-weight: normal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</span></span><span lang="RU" style="mso-ansi-language:RU">Свойство <b style="mso-bidi-font-weight:normal">Color

</b>- возвращает выбранный цвет шрифта;<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;</font><font face="Tahoma" size="2">Теперь

скомпануем все вышеописанное в

упорядоченный код:<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;</font></span><span style="color:blue"><font face="Tahoma" size="2">Private

Sub</font></span><font face="Tahoma" size="2"> mnuFont_Click()</font><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></p>

<p class="MsoNormal"><span lang="RU" style="color:green;mso-ansi-language:RU"><font face="Tahoma" size="2">''Если

возникнет ошибка, т.е пользователь нажaл на

клавишу </font></span><font face="Tahoma" size="2"><span style="color:green">Cancel</span><span lang="RU" style="color:green;mso-ansi-language:

RU">,<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><span lang="RU" style="color:green;mso-ansi-language:RU"><font face="Tahoma" size="2">‘отправиться

к обработчику ошибки -<span style="mso-spacerun: yes">&nbsp; </span>ErrorHandler<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><font face="Tahoma" size="2"><span style="color:blue">On

Error GoTo</span> ErrorHandler</font><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></p>

<p class="MsoNormal"><span lang="RU" style="color:green;mso-ansi-language:RU"><font face="Tahoma" size="2">''Обеспечиваем

генерацию ощибки</font></span><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU"><o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">CommonDialog<span lang="RU" style="mso-ansi-language:RU">1.</span>CancelError<span lang="RU" style="mso-ansi-language:RU">

= </span><span style="color:blue">True</span></font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;</font></span><font face="Tahoma" size="2"><o:p>

</o:p>

</font></p>

<p class="MsoNormal"><span lang="RU" style="color:green;mso-ansi-language:RU"><font face="Tahoma" size="2">‘Устанавливаем

тип отображения диалогово окна </font></span><font face="Tahoma" size="2"><span style="color:green">Font</span><span lang="RU" style="color:green;mso-ansi-language:RU"><o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">CommonDialog1.Flags

= cdlCFBoth <span style="color:blue">Or</span> cdlCFEffects <span style="color:blue">Or</span>

cdlCFLimitSize <span style="color:blue">Or</span> cdlCFTTOnly <span style="color:blue">Or</span>

dlCFForceFontExist</font></span><span style="mso-tab-count:1"><font face="Tahoma" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></span></p>

<p class="MsoNormal"><span style="color:green"><font face="Tahoma" size="2">‘</font></span><font face="Tahoma" size="2"><span lang="RU" style="color:green;mso-ansi-language:RU">Устанавливаем

значения минимального и максимального

размера шрифта</span><span lang="RU" style="color:green"> </span><span lang="RU" style="color:green;mso-ansi-language:RU"><o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">CommonDialog1.Min = 8</font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">CommonDialog1.Max = <span lang="RU" style="mso-ansi-language:

RU">22</span></font><span style="color:green"><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><span style="color:green"><font face="Tahoma" size="2">''</font></span><font face="Tahoma" size="2"><span lang="RU" style="color:green;mso-ansi-language:RU">Вызываем</span><span lang="RU" style="color:green">

</span><span lang="RU" style="color:green;mso-ansi-language:

RU">диалог</span><span style="color:green"> Font<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">CommonDialog1.Action = 4<span style="mso-spacerun: yes">&nbsp;

</span><span style="color:green">''</span><span lang="RU" style="color:green;

mso-ansi-language:RU">Или</span><span lang="RU" style="color:green"> </span><span lang="RU" style="color:green;mso-ansi-language:RU">же</span><span style="color:green">

CommonDialog1.ShowFont<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">&nbsp;</font><span lang="RU" style="color:green;mso-ansi-language:RU"><font face="Tahoma" size="2">''Присваиваем

выбранные свойства(к примеру текстовому

полю)<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><font face="Tahoma" size="2">Text1.FontName =

CommonDialog1.FontName</font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">Text1.FontBold =

CommonDialog1.FontBold</font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">Text1.FontItalic =

CommonDialog1.FontItalic</font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">Text1.FontSize =

CommonDialog1.FontSize</font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">Text1.FontStrikethru =

CommonDialog1.FontStrikethru</font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">Text1.FontUnderline =

CommonDialog1.FontUnderline</font><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></p>

<p class="MsoNormal"><span style="color:blue"><font face="Tahoma" size="2">Exit</font></span><font face="Tahoma" size="2"><span style="color:blue;

mso-ansi-language:RU"> </span><span style="color:blue">Sub</span></font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><span lang="RU" style="color:green;mso-ansi-language:RU"><font face="Tahoma" size="2">''Обработка

перехватываемой ошибки</font></span><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU"><o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><font face="Tahoma" size="2">ErrorHandler:</font><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></p>

<p class="MsoNormal"><span style="color:blue"><font face="Tahoma" size="2">If</font></span><font face="Tahoma" size="2">

Err.Number = 32755 <span style="color:blue">Then</span></font><font face="Tahoma" size="2">&nbsp;<o:p>

</o:p>

</font></p>

<p class="MsoNormal"><font face="Tahoma" size="2"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</span><span style="mso-spacerun:

yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="color:blue">Exit

Sub<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><span style="color:blue"><font face="Tahoma" size="2">&nbsp;</font><font face="Tahoma" size="2">End

If<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><font face="Tahoma" size="2">&nbsp;</font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Теперь

диалог <b style="mso-bidi-font-weight:normal">Font </b>полностью

готов к работе.<o:p>

</o:p>

</font></span>



<br><br>

</p></font></td>
</tr>
</tbody>', 8, 12);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (22, 'Работа с элементом управления CommonDialog - Окно диалога Color
', '<tbody><tr>
<td>
<br>



<h1 align="center">Работа с элементом управления CommonDialog - Окно диалога Color</h1>

<font face="verdana" color="#000000" size="2">



<p>Для вызова окна диалога Color неоходимо свойство CommonDialog1.Action

установить в 3 или же применить метод ShowColor.

Но, прежде необходимо установить необходимое Вам для работы значение свойства

 Flags равным одной из ниже перечисленных констант.</p>



<table border="1" cellspacing="0" cellpadding="0" style="width:100.0%;mso-cellspacing:0cm;border:outset #336699 1.0pt;">

  <tbody><tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;">

      <p align="center"><span lang="RU"><b><font face="Tahoma" size="2">Константы</font></b><font face="Tahoma" size="2"><o:p>

      </o:p></font><font size="2" face="Tahoma">

      

      </font></span>

    </p></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;">

      <p align="center"><span lang="RU"><b><font face="Tahoma" size="2">Значения</font></b></span></p></td>

    <td width="54%" style="border:inset #336699 1.0pt;">

      <p align="center"><b><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Описание</font></span></b></p></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" style="mso-layout-grid-align:none;text-autospace:none"><b><font face="Tahoma" size="2">c</font><font face="Tahoma" size="2">dlCCRGBInit<span lang="RU" style="mso-ansi-language:RU"><o:p>

      </o:p>

      </span></font></b></p>

    </td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" align="center" style="text-align:center;mso-layout-grid-align:

  none;text-autospace:none"><b><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU">0</span>x<span lang="RU" style="mso-ansi-language:RU">1<o:p>

      </o:p>

      </span></font></b></p>

    </td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Устанавливает

      начальное

      значение

      цветов для

      диалогового

      окна</font></span></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b><font face="Tahoma" size="2">cdlCCFullOpen</font></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU">0</span>x<span lang="RU" style="mso-ansi-language:RU">2</span></font></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Диалоговое

      окно

      отображается

      с

      развернутой

      палитрой </font></span><font face="Tahoma" size="2"><b>Define<span style="mso-ansi-language:

  RU"> </span>Custom<span style="mso-ansi-language:RU"> </span>Colors</b></font></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b><font face="Tahoma" size="2">cdlCCPreventFullOpen<span lang="RU" style="mso-ansi-language:RU"></span></font></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;">

      <p class="MsoNormal" align="center" style="text-align:center;mso-layout-grid-align:

  none;text-autospace:none"><b><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU">0</span>x<span lang="RU" style="mso-ansi-language:RU">4<o:p>

      </o:p>

      </span></font></b></p>

    </td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Диалоговое

      окно

      отображается

      с

      отключенной

      палитрой </font></span><font face="Tahoma" size="2"><b>Define<span style="mso-ansi-language:

  RU"> </span>Custom<span style="mso-ansi-language:RU"> </span>Colors</b></font></td>

  </tr>

  <tr>

    <td width="28%" align="center" style="border:inset #336699 1.0pt;"><b><font face="Tahoma" size="2">cdlCCHelpButton<span lang="RU" style="mso-ansi-language:RU"></span></font></b></td>

    <td width="18%" align="center" style="border:inset #336699 1.0pt;"><b><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU">0</span>x<span lang="RU" style="mso-ansi-language:RU">8</span></font></b></td>

    <td width="54%" style="border:inset #336699 1.0pt;"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Диалоговое

      окно

      отображается

      с кнопкой </font></span><font face="Tahoma" size="2"><b>Help</b></font></td>

  </tr>

</tbody></table>

<p class="MsoNormal"><font face="Tahoma" size="2"><span style="mso-bidi-font-size: 12.0pt"><span lang="RU" style="mso-bidi-font-size:12.0pt;mso-ansi-language:

RU">Не забудте

вставить в

код

обработчик

нажатия на

кнопку </span><b><span style="mso-bidi-font-size:12.0pt">Cancel</span></b><span lang="RU" style="mso-bidi-font-size:12.0pt;mso-ansi-language:RU">.<o:p>

</o:p>

</span></span></font></p>

<p class="MsoNormal"><span style="mso-bidi-font-size:12.0pt"><font face="Tahoma">&nbsp;</font></span><span style="color:blue"><font size="2" face="Tahoma">Private

Sub</font></span><font size="2" face="Tahoma"> mnuColor_Click()</font></p>

<p class="MsoNormal"><font size="2" face="Tahoma">&nbsp;</font><span lang="RU" style="color:green;mso-ansi-language:RU"><font face="Tahoma"><font size="2">''Если

возникнет

ошибка, т.е

пользователь

нажaл на

клавишу </font></font></span><font face="Tahoma"><font size="2"><span style="color:green">Cancel</span><span lang="RU" style="color:green;mso-ansi-language:

RU">,<o:p>

</o:p>

</span></font></font></p>

<p class="MsoNormal"><span lang="RU" style="color:green;mso-ansi-language:RU"><font size="2" face="Tahoma">‘отправиться

к

обработчику

ошибки -<span style="mso-spacerun: yes">&nbsp;

</span>ErrorHandler<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><span style="color:blue"><font size="2" face="Tahoma">On

Error GoTo</font></span><font size="2" face="Tahoma"> ErrorHandler</font></p>

<p class="MsoNormal"><font size="2" face="Tahoma">&nbsp;</font><span lang="RU" style="color:green;mso-ansi-language:RU"><font face="Tahoma"><font size="2">''Обеспечиваем

генерацию

ощибки</font></font></span><font face="Tahoma"><font size="2"><span lang="RU" style="mso-ansi-language:RU"><o:p>

</o:p>

</span></font></font></p>

<p class="MsoNormal"><font size="2" face="Tahoma">CommonDialog<span lang="RU" style="mso-ansi-language:RU">1.</span>CancelError<span lang="RU" style="mso-ansi-language:RU">

= </span><span style="color:blue">True</span></font><span lang="RU" style="mso-ansi-language:RU"><font size="2" face="Tahoma">&nbsp;</font></span><font size="2" face="Tahoma"><o:p>

</o:p>

</font></p>

<p class="MsoNormal"><span lang="RU" style="color:green;mso-ansi-language:RU"><font face="Tahoma"><font size="2">‘Устанавливаем

тип

отображения

диалогово

окна </font></font></span><font face="Tahoma"><font size="2"><span style="color:green">Color</span><span lang="RU" style="color:green;mso-ansi-language:RU"><o:p>

</o:p>

</span></font></font></p>

<p class="MsoNormal" style="tab-stops:191.25pt"><font size="2" face="Tahoma">CommonDialog1.Flags

<b>= </b>CdlCCRGBInit<span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font></p>

<p class="MsoNormal" style="tab-stops:191.25pt"><span style="color:green"><font size="2" face="Tahoma">&nbsp;</font></span><span style="color:green"><font face="Tahoma"><font size="2">''</font></font></span><font face="Tahoma"><font size="2"><span lang="RU" style="color:green;mso-ansi-language:RU">Вызываем</span><span lang="RU" style="color:green">

</span><span lang="RU" style="color:green;mso-ansi-language:

RU">диалог</span><span style="color:green">

Color<o:p>

</o:p>

</span></font></font></p>

<p class="MsoNormal"><font size="2" face="Tahoma">CommonDialog1.Action = 3<span style="mso-spacerun: yes">&nbsp;

</span><span style="color:green">''</span><span lang="RU" style="color:green;

mso-ansi-language:RU">Или</span><span lang="RU" style="color:green">

</span><span lang="RU" style="color:green;mso-ansi-language:RU">же</span><span style="color:green">

CommonDialog1.ShowSave<o:p>

</o:p>

</span></font></p>

<p class="MsoNormal"><font size="2" face="Tahoma">&nbsp;</font><span lang="RU" style="color:green;mso-ansi-language:RU"><font size="2" face="Tahoma">''Установка

цвета (к

примеру фона

формы)<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><font size="2" face="Tahoma">Me.BackColor =

CommonDIalog1.Color</font></p>

<p class="MsoNormal"><font size="2" face="Tahoma">&nbsp;</font><span style="color:blue"><font size="2" face="Tahoma">Exit</font></span><font face="Tahoma"><font size="2"><span style="color:blue;

mso-ansi-language:RU"> </span><span style="color:blue">Sub</span><span lang="RU" style="color:blue;mso-ansi-language:RU"><o:p>

</o:p>

</span></font></font></p>

<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font size="2" face="Tahoma">&nbsp;</font></span><span lang="RU" style="color:green;mso-ansi-language:RU"><font face="Tahoma"><font size="2">''Обработка

перехватываемой

ошибки</font></font></span><font face="Tahoma"><font size="2"><span lang="RU" style="mso-ansi-language:RU"><o:p>

</o:p>

</span></font></font></p>

<p class="MsoNormal"><font size="2" face="Tahoma">ErrorHandler:</font></p>

<p class="MsoNormal"><font size="2" face="Tahoma">&nbsp;</font><span style="color:blue"><font size="2" face="Tahoma">If</font></span><font face="Tahoma"><font size="2">

Err.Number = 32755 <span style="color:blue">Then<o:p>

</o:p>

</span></font></font></p>

<p class="MsoNormal"><font size="2" face="Tahoma">&nbsp;</font><span style="mso-spacerun: yes"><font size="2" face="Tahoma">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</font></span><font size="2" face="Tahoma"><span style="mso-spacerun:

yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="color:blue">Exit

Sub</span></font><span style="color:blue"><font size="2" face="Tahoma">&nbsp;<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><span style="color:blue"><font size="2" face="Tahoma">End

If</font><font size="2" face="Tahoma">&nbsp;<o:p>

</o:p>

</font></span></p>

<p class="MsoNormal"><span style="color:blue"><font size="2" face="Tahoma">End</font></span><font face="Tahoma"><font size="2"><span style="color:blue;

mso-ansi-language:RU"> </span><span style="color:blue">Sub</span><span lang="RU" style="color:green;mso-ansi-language:RU"><o:p>

</o:p>

</span></font></font></p>

<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font size="2" face="Tahoma">&nbsp;</font><font face="Tahoma"><font size="2">Теперь

диалог </font></font></span><font face="Tahoma"><font size="2"><b>Color</b><span lang="RU" style="mso-ansi-language:RU">

полностью

готов к

работе.<o:p>

</o:p>

</span></font></font></p>



<br><br>

</font></td>
</tr>
</tbody>', 8, 12);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (23, 'Работа с элементом управления CommonDialog - Окно диалога Save As
', '<tbody><tr>
<td>
<br>



<h1 align="center">Работа с элементом управления CommonDialog - Окно диалога Save As</h1>

<font face="verdana" color="#000000" size="2">



<p>

<font face="Tahoma">

<br><font size="2">Для <font color="#000000" size="-1">вызова окна диалодгa

<b>Save As</b> необходимо свойство <b>CommonDialog1.Action</b> установить в <b>2</b> или 

применить метод <b>ShowSave</b>. Но, прежде необходимо назначить ряд свойств.</font></font></font>

</p><ol>

<li><font size="2" color="#000000" face="Tahoma">Установить начальную директорию, которая будет открываться при вызове <b>CommonDialog1</b> - а.<br><br>





CommonDialog1.InitDir = "C:\\My Documents"<br>



Если не установить этого свойства, то по умолчанию будет открыватья директория, которую Вы

использовали в последний раз.<br><br>





</font>





</li><li><font size="2" color="#000000" face="Tahoma">Установить тип файлов, которые будут отображать диалог <b>Save As</b>. Для этого объявляем 

строковую переменную <b>strFileType</b> и присваиваем ей необходимые значения.<br>



<br><font color="#0000FF">Dim</font>  strFileType<font color="#0000FF"> As String</font><br><br>





strFileType = "All Files (*.*)|*.*|"<br>

strFileType = strFileType &amp;  " Word Document ( *.doc )|*.doc|"<br>

strFileType = strFileType &amp;  " Text Files (*.txt)|*.txt|"<br><br>





Затем свойству <b>Filter</b>, <b>CommonDialog1</b>, присваиваем 

значение переменной <b>strFileType</b>.<br><br>



CommonDialog1.Filter = strFileType<br><br>



<u>Примечание.</u> Не включайте  пробелы до и после разделителей, иначе Вы получите 

не те файлы, которые указали.<br><br>



Устанавливаем фильтр по умолчанию, выбрав для него значение <b>Word Document</b>.<br><br>





<center>CommonDialog1.FilterIndex = 2</center><br><br>



При открытии окна диалога <b>Save As</b> в текстовом окне <b>"Save As "</b>, у Вас отобразится 

надпись <b>Word Document (*.doc)</b>.<br>



</font>



</li><li><font size="2" color="#000000" face="Tahoma">И наконец, отображаем окно диалога <b>Save As</b>.<br><br>



CommonDialog1.Action = 2<br><br>



или же<br><br>



CommonDialog1.ShowSave<br><br>



Естественно, раз Вы вызвали окно диалога <b>Save As</b>, то его надо использовать по 

назначению, т.е. ввести в текстовое окно <b>File Name</b> имя файла для записи. При 

этом введенное Вами имя файла присваивается свойству <b>CommonDialog.FileName</b>.<br><br>



</font>



</li></ol>



<font size="2" color="#000000" face="Tahoma">



Зная имя файла Вы можете производить его запись соответствующими методами.





Теперь необходимо, как и при окне диалога <b>Open</b> уменьшить возможности 

возникновения ошибок.<br>

Для этого свойству <b>Flags</b> присваиваем необходимую константу.<br><br>



</font>

<dl>



<dt><font face="Tahoma" size="2"><b><font color="#000000">cdlOFNOverwritePrompt



</font></b> <font color="#000000"> - заставляет диалоговое окно <b>Save As</b> генерировать

блок сообщений, если выбранный файл уже существует, пользователь должен подтвердить, что 

бы записать новый файл поверх старго.<br><br>



На окне диалога <b>Save As</b> находится флажек для включения опции <b>"Open as read only" </b>.

Да, да это не опечатка и по этому добавим знакомую константу, которая уберет его с панели 

окна диалога.<br><br>



<b>cdlOFNHideReadOnly</b> - делает невидимым переключатель <b>Read Only</b>.<br><br>



И теперь свойство <b>Flags</b> будет выглядеть следующим образом.<br><br>



CommonDialog1.Flags = cdlOFNOverwritePrompt  or cdlOFNHideReadOnly<br><br>



Т.к. обычно окно диалога <b>Save As</b> используют с окном диалога <b>Open</b>, 

то значить у Вас свойство <b>CommonDialog1.CancelError</b> уже установленно в <b>True</b> 

и присутствует обработчик  ошибок. Если этого нет, сделайте так, как описанно в окне 

диалога <b>Open</b>.<br><br>



Теперь скомпануем все выше описанное в упорядоченный код:<br><br>



<font color="#0000FF">Private Sub</font> mnuSaveAs_Click()<br><br>



</font><font color="#008000">''Объявляем строковую переменную для назначения типов файлов



</font><font color="#000000"> <br>



<font color="#0000FF">Dim</font>  strFileType<font color="#0000FF"> As String</font><br><br>



  </font><font color="#008000">''Если возникнет ошибка, т.е.пользователь нажал на клавишу Cancel,<br>

''отправится к обработчику ошибки - ErrorHandler</font><font color="#000000"><br>



<font color="#0000FF">On Error GoTo</font> ErrorHandler<br><br>



  </font><font color="#008000">''Обеспечиваем генерацию ошибки</font><font color="#000000"><br>

CommonDialog1.CancelError = <font color="#0000FF">True</font><br><br>



  </font><font color="#008000">''Инициализируем переменную strFileName</font><font color="#000000"><br>

strFileType = "All Files (*.*)|*.*|"<br>

strFileType = StrFileType &amp;  " Word Documents ( *.doc )| *.doc |"<br>

strFileType = StrFileType &amp;  " Text Files (*.txt)|*.txt|"<br><br>



  </font><font color="#008000">''Присваиваем ее свойству Filter</font><font color="#000000"><br>

CommonDialog1.Filter = strFileType<br><br>





  </font><font color="#008000">''Устанавливаем необходимый индекс</font><font color="#000000"><br>

CommonDialog1.FilterIndex = 2<br><br>



  </font><font color="#008000">''Присваиваем начальную директорию свойству InitDir</font><font color="#000000"><br>

CommonDialog1.InitDir = "C:\\DOCUMENTS"<br><br>



  </font><font color="#008000">''Обеспечиваем защиту от неправильно введенного файла или директории, 

а аткже скрываем флажек Read Only</font><font color="#000000"><br>

CommonDialog1.Flags = cdlOFNOverwritePrompt or cdlOFNHideReadOnly<br><br>

 



  </font><font color="#008000">''Вызываем диалог Save As</font><font color="#000000"><br>

CommonDialog1.Action = 2 </font><font color="#008000">''Или же CommonDialog1.ShowSave</font><font color="#000000"><br><br>



<font color="#0000FF">Exit Sub</font><br><br>



  </font><font color="#008000">''Обработка перехватываемой ошибки</font><font color="#000000"><br>

<font color="#0000FF">If</font> Err.Number = 32755 <font color="#0000FF">Then</font><br><br>



                       	            <font color="#0000FF">Exit Sub</font><br><br>



<font color="#0000FF">End If</font><br><br>



<font color="#0000FF">End Sub</font><br><br>



Теперь диалог <b>Save As</b> полностью готов к работе.</font></font>



<br><br>

</dt></dl></font></td>
</tr>
</tbody>', 8, 12);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (25, 'Разные советы - Контролы, объекты, эл. управления
', '<tbody><tr>
<td>
<br>

<h1 align="center">Разные советы - Контролы, объекты, эл. управления</h1>

<font face="verdana" color="#000000" size="2"> 

<font face="Tahoma" size="2"><a href="#1"><font color="#000000">Как очистить от записей
объект <b>ListBox</b></font></a></font><br>

  
<font face="Tahoma" size="2"><a href="#2">
<font color="#000000">Защита пароля в <b>TextBox</b></font></a></font><br>

<font face="Tahoma" size="2"><a href="#3">
<font color="#000000"><b>Resize</b> всех контролов на форме</font></a>   

<hr width="100%">

<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
 <font face="Tahoma" size="2"><a name="#1"></a>Как очистить от записей
объект <b>ListBox</b></font>
  
          <p><font color="#000080">Do Until</font> List1.ListCount = 0<br>
          &nbsp;&nbsp;&nbsp; List1.RemoveItem 0<br>
          <font color="#000080">Loop</font></p>
                       <font face="Tahoma" size="2">&nbsp;Очищает
                       моментально любой листбокс.</font>
        



<p><font face="Tahoma" size="2">&nbsp;<a href="#B"><font color="#000000"><b>Назад</b></font></a></font></p>
        



<hr width="100%">


&nbsp;<font face="Tahoma" size="2"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</b><a name="#2"></a>Защита пароля в <b>TextBox</b></font>
<p>

<font size="2" face="Tahoma">Есть
много программ, снимающих маски с окон с паролями... Все, наверное, видели:
наводишь мышку на окно со звёздочками и в окне программы-взломщика появляется
текст пароля. Приложения, написанные на Visual Basic не
защищены
от этого... Другими словами в текстовом окне всё же находится текст, только
замаскированный. Я же нашёл как этого избежать:</font>
</p><ul>
<li>
<font size="2" face="Tahoma" color="#000000">в
разделе формы General Declarations объявите переменную, котрая будет
содержать код:</font></li>
</ul>
<font size="2" face="Tahoma"><font color="#000099">Dim</font><font color="#000000">
pswd </font><font color="#000099">As String</font></font>
<ul>
<li>
<font size="2" face="Tahoma" color="#000000">в
свойствах текстового поля установите в PasswordChar
звёздочку "*".
Теперь кликните по текстовому полю два раза и выберите событие
Text1_KeyPress,
впишите:</font></li>
</ul>
<font face="Tahoma" size="2"><font color="#000099">Private
Sub</font><font color="#000000"> Text1_KeyPress(KeyAscii As Integer)</font>
<br><font color="#000000">&nbsp;&nbsp;
pswd = pswd + Chr(KeyAscii)</font>
<br><font color="#000000">&nbsp;&nbsp;
KeyAscii = Asc("*")</font>
<br><font color="#000099">End
Sub</font></font>
<ul>
<li>
<font size="2" face="Tahoma" color="#000000">Теперь
нажатия будут отлавливаться, а
передаваться будут текстовому полю только
звёздочки! И программа-взломщик пароль уже не достанет!!! Если кто-то хочет
сделать так, как в Linux''e, т.е. никаких звёздочек нет вообще, то строку
KeyAscii
= Asc("*") надо заменить на KeyAscii = 0 и всё!</font></li>
</ul>

<p><font face="Tahoma" size="2"><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font></p>
<hr>
<p><span style="font-family: Tahoma; mso-bidi-font-family: Times New Roman"><b>&nbsp;</b>
<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</b></span><font face="Tahoma" size="2"><span style="font-family:
Tahoma;mso-bidi-font-family:&quot;Times New Roman&quot;"></span><a name="#3"></a></font><span style="font-family:
Tahoma;mso-bidi-font-family:&quot;Times New Roman&quot;"><b>Resize</b> всех контролов на форме
</span>
</p><p><span style="font-family:
Tahoma;mso-bidi-font-family:&quot;Times New Roman&quot;"><br><font color="#000080">Option Explicit</font><br>
<font color="#000080">
Const</font> K = 1.25&nbsp;
</span>
</p><p><span style="font-family:
Tahoma;mso-bidi-font-family:&quot;Times New Roman&quot;"> ''<font color="#008000">если 800/600 то получится 1.33333, но
лучше 1.25<br>
''эта функция относится к определению
разрешения экрана</font>
</span>
</p><p><span style="font-family:
Tahoma;mso-bidi-font-family:&quot;Times New Roman&quot;"><br>
<font color="#000080">
Private Declare Function</font> GetSystemMetrics <font color="#000080"> Lib</font> "user32"
(<font color="#000080">ByVal</font> nIndex <font color="#000080">
As Long</font>) <font color="#000080"> As Long</font> <o:p>
 <o:p>
</o:p>
&nbsp;
</o:p></span>
</p><p>
<span style="font-size:10.0pt;mso-bidi-font-size:12.0pt;
font-family:Tahoma;mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:
&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:EN-US;
mso-bidi-language:AR-SA"><font color="#000080">Private Sub</font> Form_Load()<br>
''определяем разрешения экрана<br>
<font color="#000080">
Select Case</font> GetSystemMetrics(0)<br>
&nbsp;<font color="#000080">Case</font> 640<br>
Form1.Width = 9600<br>
<font color="#008000">
''Command1.Width=1500</font><br>
&nbsp;<font color="#000080">Case</font> 800<br>
Form1.Width = Form1.Width * K<br>
<font color="#008000">
''Command1.Width = Command1.Width * K</font><br>
<font color="#000080">
End Select</font><br>
Form1.Caption = GetSystemMetrics(0) &amp; "x" &amp;
GetSystemMetrics(1)<br>
<font color="#000080">
End Sub</font><br style="mso-special-character:line-break">
<!--[if !supportLineBreakNewLine]--><br style="mso-special-character:line-break">
<!--[endif]--></span><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a>
         
<br><br>

</p></font></font></td>
</tr>
</tbody>', 8, 13);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (26, 'Кнопки, клавиши и все о них
', '<tbody><tr>
<td>
<br>

<h1 align="center">Кнопки, клавиши и все о них</h1>


<font face="Tahoma" size="2">
<a href="#1"><font color="#000000">Как поменять цвет кнопки 
(<b>CommandButtan</b>)</font></a><br>
 </font>
        



<font face="Tahoma" size="2">
<a href="#2"><font color="#000000">Имитация
нажатия кнопки</font></a></font> <br>

<font size="2" face="Tahoma"><a href="#3">
<font color="#000000">Управление клавишами <b>&lt;-</b>
и <b>-&gt;</b></font></a></font>
<br>
        
<font size="-1"><font face="Tahoma">
<a href="#4">
<font color="#000000">Кнопки - картинки</font></a></font></font>
        
<br>


<font size="-1"><font face="Tahoma"><a href="#5"><font color="#000000">
Кнопка <b>Help</b> в <b>MsgBox</b></font></a></font>
<br>

</font>
<a href="#6"><font color="#000000" face="Tahoma" size="2">
Эмуляция программы на нажатие <b> Enter,</b>
при системном сообщении
из браузера</font></a>


<font size="-1">

<hr width="100%">


&nbsp;&nbsp;<font face="Tahoma" size="2"><b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
 </font><font face="Tahoma" size="2"><a name="#1"></a>Как поменять цвет
 кнопки (<b>CommandButtan</b>)</font>
</font>
 <pre><font face="Tahoma" size="2">1. Устанавливаешь новую кнопку<o:p>
</o:p>2. В свойстве Style для кнопки устанавливаешь значение 1 - графический<o:p>
</o:p>3. В свойстве BackColor в палитре выбираешь нужный цвет.</font></pre>


<font size="-1">
 <pre><font face="Tahoma" size="2"><font color="#000000"><b> </b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font></pre>



<hr width="100%">





&nbsp;&nbsp;<b>&nbsp;<font face="Tahoma" size="2"></font></b><span lang="RU" style="font-family:Tahoma;
mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;layout-grid-mode:
line">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><font size="-1"><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU"><a name="#2"></a></span></font></font><span lang="RU" style="font-family:Tahoma;
mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;layout-grid-mode:
line"><font face="Tahoma" size="2"><span style="font-family: Tahoma; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; layout-grid-mode: line">Имитация
нажатия кнопки</span></font></span> &nbsp;&nbsp;
<p><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU">Иногда
создавая программы в которых
присутствовали элементы вычислительных
операций, мне приходилось создавать
кнопочные панели. Для создания визуального
эффекта нажатия той или иной кнопки на
форме, при вводе данных с клавиатуры, я
использую события <b>KeyDown</b><b> </b>и <b>KeyUp</b> того
текстового поля куда вводится информация.<br>
Делается это так :<o:p>
</o:p>
</span></font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU">
В зависимости от условий задачи Вы или
устанавливаете&nbsp; свойствo <b>Text1.TabIndex = 0 </b>(на
стадии разработки) или передаете ему
фокус&nbsp;<b> Text1.SetFocus .</b></span></font></p>
<p><font face="Tahoma" size="2"><span style="mso-ansi-language: RU" lang="RU">В
процедуру события </span><span lang="RU" style="mso-ansi-language:RU"><b>KeyDown&nbsp;</b>
текстового поля вписываем</span></font></p>
<p><font face="Tahoma" size="2"><span lang="RU" style="mso-bidi-font-size: 12.0pt; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU"><font color="#0000FF">Private Sub</font> Text1_KeyDown(KeyCode
<font color="#0000FF"> As Integer</font>, Shift <font color="#0000FF"> As
Integer</font>)
</span></font></p>
<p><font face="Tahoma" size="2"><span lang="RU" style="mso-bidi-font-size: 12.0pt; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU"><font color="#0000FF">If</font> KeyCode = 97
<font color="#0000FF"> Then</font> Command1.Default = <font color="#0000FF"> True</font><br>
<br>
<font color="#0000FF">End Sub</font><br>
<br>
</span><span style="mso-bidi-font-size: 12.0pt; mso-bidi-font-family: Times New Roman">а
в&nbsp;</span></font><font face="Tahoma" size="2"><span style="mso-ansi-language: RU" lang="RU">
процедуру события </span></font><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU"><b>KeyUp</b></span></font></p>
<p><font face="Tahoma" size="2"><span style="mso-ansi-language: RU" lang="RU"><font color="#0000FF">Private Sub</font> Text1_KeyUp(KeyCode
<font color="#0000FF"> As Integer</font>, Shift <font color="#0000FF"> As
Integer</font>)</span></font></p>
<p><font face="Tahoma" size="2"><span style="mso-ansi-language: RU" lang="RU"><font color="#0000FF">If</font> KeyCode = 97
<font color="#0000FF"> Then</font> Command1.Default = <font color="#0000FF"> False</font><br>
<br>
<font color="#0000FF">End Sub</font></span></font></p>
<p><font face="Tahoma" size="2"><span lang="RU" style="mso-bidi-font-size: 12.0pt; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU"><br>
В </span><span style="mso-bidi-font-size: 12.0pt; mso-bidi-font-family: Times New Roman">текстовом
поле <b>Text1.Text&nbsp;</b> начинает печататься
вводимая информация, а кнопки на панели
указывают какя клавиша была нажата. Пример
приведен только для одной клавиши - <b>1</b>.</span></font></p>


<p><font face="Tahoma" size="2"><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font><b>&nbsp;</b>
<font size="-1">

<b>

</b></font></p><font size="-1"><b>


<hr width="100%">

</b>

</font>





<b><font face="Tahoma" size="2">&nbsp;</font></b><font face="Tahoma" size="2"><b>
</b></font><font size="2" face="Tahoma"><b>&nbsp;&nbsp; </b><a name="#3"></a>Управление
клавишами <b>&lt;-</b> и <b>-&gt;</b></font>
<p>
<font size="2"><font face="Tahoma">Приветствую всех <b> Visual
Basic</b>-истов.
Решился наконец написать пару строчек для
одного из моих любимых сайтов. Недавно
пришлось заглянуть в <b> Help </b> - файл</font><span style="font-family:&quot;Courier Cyrillic&quot;">
 </span>
<font face="Tahoma">
моего</font><span style="font-family:&quot;Courier Cyrillic&quot;">
 </span>
<font face="Tahoma">земляка, Армена Мнацаканяна, а я
туда частенько заглядываю, но ответа на
свой вопрос не нашел. Мне нужно было, чтоб
при помощи стрелок ''Вправо'' и ''Влево''
переходить от одного <b> TextBox</b> к другому. Сейчас
решение есть и я его привожу.</font>

</font>
</p>
<p class="MsoNormal" style="text-align:justify"><font face="Tahoma" size="2"><span style="mso-bidi-font-size: 10.0pt"><font color="#0000FF"><b style="mso-bidi-font-weight:
normal">Private
Sub</b></font> <b style="mso-bidi-font-weight:
normal"> Text1_KeyDown(KeyCode <font color="#0000FF"> As Integer</font>, Shift
<font color="#0000FF"> As Integer</font>)</b></span>&nbsp;<o:p>
</o:p>
</font></p>
<h1 style="text-align:justify"><font size="2" face="Tahoma"><font color="#0000FF">If</font>
KeyCode = 39 <font color="#0000FF"> And</font> Text1.SelStart = Len(Text1.Text) <font color="#0000FF"> Then</font></font></h1>
<font face="Tahoma">&nbsp;<font size="2"><b>Text2.SetFocus</b>&nbsp;<o:p>
</o:p></font>
&nbsp;</font>
<h1 style="text-align:justify"><font size="2" color="#0000FF" face="Tahoma">End
Sub</font><b><span style="font-family:&quot;Courier Cyrillic&quot;"><font size="2">
</font></span></b></h1><b>

</b>

<p class="MsoNormal" style="text-align:justify"><font size="2"><b><font face="Tahoma">KeyCode=39</font></b>
<font face="Tahoma">
 - фиксируется нажатие клавиши ''Вправо''<br>
 
<b>Text1.SelStart = Len(Text1.Text)</b> –Определяем
местонахождение курсора, в данном случае,
что б курсор находился в конце <b>Text1</b> <b>Text2.SetFocus</b> –
передаем фокус <b>Text2</b></font></font><b><font face="Tahoma" size="2"><span style="font-size:10.0pt;font-family:Tahoma;
mso-bidi-font-family:&quot;Times New Roman&quot;;font-weight:normal"><o:p>
</o:p>
</span></font></b></p><b>

<p class="MsoNormal" style="text-align:justify"><font face="Tahoma" size="2"><b style="mso-bidi-font-weight:
normal"><span style="mso-bidi-font-size: 10.0pt"><font color="#0000FF">Private
Sub</font> Text1_KeyDown(KeyCode <font color="#0000FF"> As Integer</font>, Shift
<font color="#0000FF"> As Integer</font>)</span></b>&nbsp;<o:p>
</o:p>
</font></p>
<h1 style="text-align:justify"><font size="2" face="Tahoma"><font color="#0000FF">If</font>
KeyCode = 37 <font color="#0000FF"> And</font> Text2.SelStart = 0 <font color="#0000FF"> Then</font>
</font></h1>
<h1 style="text-align:justify"><font size="2" face="Tahoma">&nbsp;Text1.SetFocus<o:p>
&nbsp;
</o:p></font></h1>
<h1 style="text-align:justify"><b style="mso-bidi-font-weight:
normal"><font face="Tahoma" color="#0000FF" size="2">End
Sub</font></b><font face="Tahoma" size="2"><o:p>
</o:p>
</font></h1>

</b>

<p class="MsoNormal" style="text-align:justify"><font face="Tahoma" size="2"><b>KeyCode
= 37</b>&nbsp;- фиксируется нажатие клавиши ''Влево''<b>
<br>
Text2.SelStart = 0</b>&nbsp; – определяем
местонахождение курсора, в данном случае,
что б курсор находился в начале <b>Text2.Tex1.SetFocus</b> –
передаем фокус <b>Text1</b></font><b><font face="Tahoma" size="2"><span style="mso-bidi-font-family: Times New Roman; mso-bidi-font-style: italic"><o:p>
&nbsp;
</o:p></span></font></b></p>

<p class="MsoNormal" style="text-align:justify"><font face="Tahoma" size="2"><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font><b><span style="font-family:Tahoma;
mso-bidi-font-family:&quot;Times New Roman&quot;;mso-bidi-font-style:italic">

</span></b></p>

<font size="-1">

<b>

<font face="Courier New,Courier">
<hr width="100%"></font>

</b>

</font>

<b><font face="Tahoma" size="2">&nbsp;&nbsp;</font></b><b><font face="Tahoma" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font></b><font size="-1"><font face="Tahoma"><a name="#4"></a>Кнопки - картинки</font>
<p>

<font face="Tahoma">Очень часто вместо обычных кнопок используются картинки.
Т.е. существует всего три картинки - одна на которую будут жать (img1),
вторая отжатая (img2) и третья нажатая (img3) (img2 и img3 - невидимы).
Делаем это так:</font></p>
<p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub </font>Form_Load()</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;
''при загрузке формы картинка 1 принимает вид _</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;&nbsp;
картинки 2 (отжатая)</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; img1.Picture
= img2.Picture</font>
<br><font size="-1" color="#000099">End
Sub</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub </font>Image1_MouseDown(<font color="#000000">Button </font><font color="#000099">As
Integer</font>, Shift <font color="#000099">As Integer</font>, _</font>
<br><font size="-1">X <font color="#000099">As
Single</font>, Y <font color="#000099">As Single</font>)</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;
''при нажатии мышкой на картинку 1, она принимает вид _</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;&nbsp;
картинки 3 (нажатая)</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; img1.Picture
= img3.Picture</font>
<br><font size="-1" color="#000099">End
Sub</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub </font>Image1_MouseUp(Button <font color="#000099">As Integer</font>,
Shift <font color="#000099">As Integer</font>, _</font>
<br><font size="-1">X <font color="#000099">As
Single</font>, Y <font color="#000099">As Single</font>)</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;
''при отпускании кнопки мышки картинка 1, она снова принимает вид _</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;&nbsp;
картинки 2 (отжатая)</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; img1.Picture
= img2.Picture</font>
<br><font size="-1" color="#000099">End
Sub</font></font>
</p><p><font size="-1" face="Tahoma">Этот приём знает каждый...
Но есть в нём один недостаток, а именно: при серии непрерывных кликов на
объект картинка почему-то реагирует через раз. Т.е. то нажмётся, то не
нажмётся. Так вот вот сам совет :-) : чтобы этого избежать в событие Img1_MouseDown
нужно вставить строку</font>
</p><p><font size="-1" face="Tahoma">SendKeys "A"</font>
</p><p><font size="-1" face="Tahoma">Т.е. картинке одновременно
посылается нажатая клавиша. Почему так, понять не могу сам. Но в скобках,
конечно же, не важна буква "A" - там может стоять и В и С. Главное само
событие.</font>
</p></font><p><font size="-1"></font><font color="#000000" face="Tahoma" size="2"><b>&nbsp;</b></font><font size="-1"><font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font></font>
</p><p>&nbsp;<font size="-1">

<b>

</b></font></p><hr width="100%"><font size="-1"><b>

</b>

<b><font face="Tahoma" size="2"></font></b></font><b><font face="Tahoma" size="2">&nbsp;&nbsp;
</font></b><font size="-1"><font face="Tahoma"><a name="#5"></a>Кнопка <b>Help</b> в <b>MsgBox</b></font>
<p><font face="Tahoma" size="-1">Если Вам нужно сделать MsgBox с кнопкой на определённую станицу Вашего хелпа, сделайте следующее:
</font>
</p>
<p>
<font face="Tahoma" size="-1">
MsgBox "Азбука Visual Basic", vbMsgBoxHelpButton, "http://www.cm.f2s.com", _<br>"с:\\путь_к_файлу", 10
</font>
</p><p>
<font face="Tahoma" size="-1">
Где 10 - это номер страницы Вашего хелп-файла!
</font>

</p><p>
<font face="Tahoma">&nbsp;</font><font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>
</p><hr>

</font>

</font>
<a name="#6"></a>
<p><font color="#000099" face="Tahoma" size="2">&nbsp;</font><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font><font color="#000099"><font face="Tahoma" size="2"><font size="-1">Напишите
как , что бы прога на Байсике эмулировала нажатие Enter на системном&nbsp;</font></font></font><font color="#000099" face="Tahoma" size="2">&nbsp;
</font><font size="-1"><font face="Tahoma" size="2"><font color="#000099">сообщении
из браузера. Пришло много аллертов , а неохота выгружать браузер - лучше
пусть прога старается нажимает ENTER на сообщение.</font>
<br>
<br><font color="#000000">Если я
всё правильно понял, то от меня требуется программа, которая периодически
шлёт браузеру нажатие клавиши ENTER? Итак, вперёд! Для того, чтобы чему-нибудь
послать нажатие клавиши, это нужно сначала активизировать. Для активизирования
окна отлично подходит комманда AppActivate. Но она требует заголовок окна,
которое нужно активизировать, или хотя бы первые буквы заголовка. В этом
случае нам повезло - когда браузер шлёт алерты, то в заголовках стоит его
имя! В моём случaе это Netscape. Если же у Вас Internet Explorer, то и
стоять там будет что-то подобное :-) - что выявите сами. А теперь нам нужно
написать саму программу.</font></font>
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000000">1.Создайте
стандартный проект.</font>
<br><font color="#000000">2.На него
повешайте объект таймер. Интервал же нужно установитьв зависимости от того,
с какой частотой должны посылаться нажатия. Возьмём одну десятую секунды
- Interval = 100.</font>
<br><font color="#000000">3.Теперь
нужно сделать двойной клик по таймеру и открыть окно Code. Впишите:</font></font>
</font></p><p><font size="-1"><font size="2" face="Tahoma"><font color="#000099">Private
Sub</font><font color="#000000"> Timer1_Timer()</font></font>
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000099">On Error
GoTo</font><font color="#000000"> abc </font><font color="#006600">''в случае
возникновения ошибки выходим на _</font>
<br><font color="#006600">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
метку abc, ошибки возникнут непременно, т.к. _</font>
<br><font color="#006600">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
программа будет работать и во время отсутствия _</font>
<br><font color="#006600">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
окон - аллертов. Активирование же окна, которого нет _</font>
<br><font color="#006600">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
вызывает ошибку</font>
<br><font color="#000000">AppActivate
"Netscape" </font><font color="#006600">''Активируем окно с заголовком Netscape
_</font>
<br><font color="#006600">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
''(Internet Explorer)</font>
<br><font color="#000000">SendKeys
"~"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font><font color="#006600">''Посылаем
клавишу ENTER: строка "~" идеентична</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</font><font color="#006600">''строке "{ENTER}"</font></font>
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000000">abc:&nbsp;&nbsp;&nbsp;&nbsp;
</font><font color="#006600">''а это метка abc, на которую мы выходим при
возникновинии _</font>
<br><font color="#006600">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ошибки, метка abc ведёт нас прямо к выходу из процедуры</font>
<br><font color="#000099">End Sub</font></font>
</font></p><p><font size="-1"><font size="2" face="Tahoma" color="#000000">Теперь
же нужно просто запустить программу и все аллерты она будет закрывать сама!
Кстати, получилась весьма полезная программка для пользователей Netscape
- он всё время спрашивает загружать или нет? :)</font>
</font></p><p><font size="-1">
<font face="Tahoma">&nbsp;</font><font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>         

<br><br>

</font></p></td>
</tr>
</tbody>', 8, 13);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (27, 'Меню
', '<tbody><tr>
<td>
<br>

<h1 align="center">Меню</h1>

<font face="Tahoma" size="2">
<a href="#1"><font color="#000000">Разделительная полоска</font></a></font>
 <br>       



<font face="Tahoma" size="2">
<a href="#2"><font color="#000000">Полоска подчёркивающая меню</font></a></font>



<hr width="100%">


&nbsp;<font size="-1"><font face="Tahoma"><a name="#1"></a>Чтобы в меню между пунктами ввести разделительную полоску,
в окне "<b>Menu Editor</b>" в поле "<b>Caption</b>" введите "-" (тире), а поле
"<b>Name</b>"
любое имя.</font>

</font>

<p><font face="Tahoma" size="2"><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>
<font size="-1">

<b>

<font face="Courier New,Courier">
</font></b></font></p><font size="-1"><b><font face="Courier New,Courier">
<hr width="100%"></font>

</b>

<font face="Tahoma"><a name="#2"></a>Если ваша форма содержит меню, введите в событие
<b> Form_Load</b>
этот код и под меню появится маленькая полоска, подчёркивающая меню:&nbsp;</font>
<p><font face="Tahoma"><font size="-1">AutoRedraw = <font color="#000099">True</font></font>
<br><font size="-1">ScaleMode = 3&nbsp;</font>
<br><font size="-1" color="#000099">Cls&nbsp;</font>
<br><font size="-1"><font color="#000099">Line</font>
(0, 0)-<font color="#000099">Step</font>(ScaleWidth, 0), QBColor(8)&nbsp;</font>
<br><font size="-1"><font color="#000099">Line</font>
(0, 1)-<font color="#000099">Step</font>(ScaleWidth, 0), QBColor(15)&nbsp;</font>
<br><font size="-1">AutoRedraw = <font color="#000099">False&nbsp;</font></font></font>
</p></font><p><font size="-1">

</font>

<font color="#000000" face="Tahoma" size="2"><b>&nbsp;</b></font><font size="-1"><font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>


<br><br>

</font></p></td>
</tr>
</tbody>', 8, 13);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (28, 'Операторы, функции, процедуры
', '<tbody><tr>
<td>
<br>

<h1 align="center">Операторы, функции, процедуры</h1>

<font size="2" face="Tahoma">
<a href="#1"><font color="#000000">Оператор <b>SendKey</b></font></a></font>
<br>




<font size="2" face="Tahoma"><span lang="RU" style="mso-ansi-language:RU">
<a href="#2"><font color="#000000">Оператор<o:p>
</o:p></font></a></span><a href="#2"><font color="#000000"><b>AppAtivate</b></font></a></font>
<br>
<font size="-1"><font size="-1"><font face="Tahoma">
<a href="#3"><font color="#000000">Сочетание 
операторов <b> Chr(13) + Chr(10)</b></font></a></font> 
<br>

 
</font> 
 
<font face="Tahoma"><a href="#4">
<font color="#000000">Смена значений двух переменных</font></a></font> 
 
<br>

<font face="Tahoma"><a href="#5">
<font color="#000000">Функция <b>Environ</b></font></a></font>

 <br>




<font face="Tahoma"><a href="#6">
<font color="#000000">Смена значение переменной&nbsp;<b> Boolean</b>
на противоположное</font></a></font>




<hr width="100%">



<font face="Tahoma" size="2">
&nbsp;
</font><font size="2" face="Tahoma">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </font><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU"><a name="#1"></a>Оператор<o:p>
</o:p>
 </span>
</font>&nbsp;<span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2"><b>SendKey&nbsp;</b></font></span>
<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">С
помощью оператора </font></span><font face="Tahoma" size="2"><b>SendKey</b><span lang="RU" style="mso-ansi-language:RU">
можно симитировать нажатие клавиши, котрое
записывается в буфер клавиатуры. Система
при этом не отличает такой ввод от ''настоящего''
ввода.</span></font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;<o:p>
</o:p>
</font></span></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><b>SendKey Ctrl [,Wait]</b></font><font face="Tahoma" size="2">&nbsp;<o:p>
</o:p>
</font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><b>Wait</b><span lang="RU" style="mso-ansi-language:RU">
– параметр с помощью которого определяется
режим ожидания обработки имитации нажатия
клавиши. Если значение параметра </span><font color="#000080">False</font><span lang="RU" style="mso-ansi-language:
RU"> (по умолчанию), то управление
возвращается процедуре немедленно после
посылки о нажатии клавиши, если значение <font color="#000080">True</font>
, сообщение должно быть обработано, прежде
чем управление будет передано процедуре.</span></font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;<o:p>
</o:p>
</font></span></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><b>SendKey<span lang="RU" style="mso-ansi-language:RU">
“+{</span>F</b><span lang="RU" style="mso-ansi-language:RU"><b>1}”</b></span></font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;<o:p>
</o:p>
</font></span></p>
<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Эта
строка посылает имитацию нажатия клавиши <b>[</b></font></span><b><font face="Tahoma" size="2">Shift<span lang="RU" style="mso-ansi-language:
RU"> + </span>F</font></b><span lang="RU" style="mso-ansi-language:RU"><b><font face="Tahoma" size="2">1]</font></b><o:p>
&nbsp;
</o:p></span></p>





<p class="MsoNormal"><font face="Tahoma" size="2"><font color="#000000"><b> </b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font><span lang="RU" style="mso-ansi-language:RU">
</span></p>





<hr width="100%">


<font face="Tahoma" size="2">&nbsp;<b>
 </b></font><font size="2" face="Tahoma">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </font><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language:RU"><a name="#2"></a>Оператор<o:p>
</o:p></span><b>AppAtivate</b></font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;<o:p>
</o:p></font></span>
<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Для
передачи фокуса приложению существует
оператор </font></span><font face="Tahoma" size="2"><b>AppAtivate</b><span lang="RU" style="mso-ansi-language:RU">
:<o:p>
</o:p>
</span></font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><b>AppAtivate Title [,Wait]</b></font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><b>Title</b><span style="mso-ansi-language:RU">
<span lang="RU">– это текст заголовка приложения.
При этом не имеет значения вид написания –
прописными буквами или строчными.<o:p>
</o:p>
</span></span></font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><b>Wait</b><span lang="RU" style="mso-ansi-language:RU">
– параметр с помощью которого определяется
режим ожидания обработки. Если значение
параметра </span><font color="#000080">False</font><span lang="RU" style="mso-ansi-language:RU"> (по
умолчанию), то управление возвращается,
если значение <font color="#000080"> True </font> , сообщение должно быть
обработано, прежде чем управление будет
передано процедуре.<o:p>
</o:p></span></font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;<o:p>
</o:p>
</font></span></p>
<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Пример</font></span><font face="Tahoma" size="2">:<o:p>
 &nbsp;<o:p>
</o:p>
</o:p></font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><font color="#000080">Private Sub</font> Command1_Click ()<o:p>
 &nbsp;<o:p>
</o:p>
</o:p></font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><font color="#000080">Dim</font> RetVal
<font color="#000080"> As Variant<o:p>
 </o:p></font>&nbsp;<o:p>
</o:p>
</font></p>
<p class="MsoNormal"><font face="Tahoma" size="2">RetVal = <font color="#000080"> Shell</font> (“calc.exe”,
vbNormalFocus)</font></p>
<p class="MsoNormal"><font face="Tahoma" size="2">AppActivate “calculator”, <font color="#000080">
False</font></font></p>
<p class="MsoNormal"><font face="Tahoma" size="2">SendKeys<span style="mso-spacerun: yes">&nbsp;
</span>“1{+}2= ^ C% {F4} ”, <font color="#000080"> True</font></font></p>
<p class="MsoNormal"><font face="Tahoma" size="2">Text1.Tex t= Clipboard.
GetText<span lang="RU" style="mso-ansi-language:RU">()<o:p>
</o:p></span></font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">&nbsp;<o:p>
</o:p>
</font></span></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><span style="mso-bidi-font-family: Times New Roman">End</span><span style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU">
</span><span style="mso-bidi-font-family: Times New Roman">Sub</span><span lang="RU" style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU"><o:p>
</o:p></span></font><span lang="RU" style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU"><font face="Tahoma" size="2">&nbsp;<o:p>
</o:p>
</font></span></p>
<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">В
данном примере запускается стандартная
программа калькулятор </font></span><font face="Tahoma" size="2"><span style="mso-bidi-font-family: Times New Roman"><b>Windows</b></span><span lang="RU" style="mso-ansi-language:RU">.
Затем суммируются числа <b> 1</b> и <b>2</b>, результат
вычисления копируется в буфер обмена и
калькулятор закрывается.<o:p>
&nbsp;
</o:p></span></font></p>





<p class="MsoNormal"><font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>

<b>

</b></p><b>





<hr width="100%">

</b>

<font face="Tahoma">&nbsp; &nbsp;&nbsp;
<a name="#3"></a>Сочетание
операторов <b> Chr(13) + Chr(10)</b> можно заменять константой
<b>vbCrLf</b>.&nbsp; сообщил о возможности ввода констаны
<b>vbNewLine</b>! И правда звучит намного лучше, чем
<b>vbCrLf</b>.</font>
<p><font face="Tahoma" size="2"><font color="#000000"><b> </b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font></p>

<b>

<font face="Courier New,Courier">
<hr width="100%"></font>

</b>

<font face="Tahoma"><a name="#4"></a>Если в течении работы программы Вам нужно несколько
раз менять значения двух переменных, то используйте эту процедуру:</font>
<p><font face="Tahoma"><font size="-1"><font color="#000099">Sub
Swap</font> (V1 <font color="#000099">As Variant</font>, V2 <font color="#000099">As
Variant</font>)</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; <font color="#000099">Dim
</font>Mk
<font color="#000099">As
Variant</font></font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; Mk
= V2</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; V2
= V1</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; V1
= Mk</font>
<br><font size="-1" color="#000099">End
Sub</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Вызов:</font>
<br><font size="-1" color="#000000">Swap
x, y</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Но
объявление перменных желательно поменять с Variant на то, которое нужно
Вам - меньше памяти надо будет. А эта процедура - универсальна! Чтобы не
содержали аргументы V1 и V2, их значения поменяются местами.</font>
</p><p><font face="Tahoma" size="2"><font color="#000000"><b> </b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>
</p><p>&nbsp;<font color="#000000">

<b>

<font face="Courier New,Courier">
</font></b></font></p><hr width="100%"><font color="#000000"><b>

</b>

<font face="Tahoma"><a name="#5"></a>В Бэйсике есть одна ОЧЕНЬ полезная, но многими
забытая функция <b>Environ</b>! Она возвращает имена и содержание всех переменных
среды операционной системы! Так, например, чтобы получить директорию
Windows, совсем не надо прибегать к API-функции <b>GetWindowsDirectory</b>!
А получить её можно так:</font></font>
<p><font size="-1" face="Tahoma" color="#000000">ABC
= Environ ("windir")</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">И
ВСЁ!</font>
<br><font color="#000000"><font size="-1">Но
и это ещё не всё! Также можно получить следующие перменные:</font></font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000000">ABC
= Environ ("TMP") </font><font color="#006600">''директория временных файлов
TEMP</font></font>
<br><font size="-1"><font color="#000000">ABC
= Environ ("BLASTER") </font><font color="#006600">''координаты звуковой
карты</font></font>
<br><font size="-1"><font color="#000000">ABC
= Environ ("PATH") </font><font color="#006600">''пути, объявленные в autoexec.bat</font></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">НО
И ЭТО ВСЁ ЕЩЁ НЕ ВСЁ!!!!</font>
<br><font color="#000000"><font size="-1">Чтобы
получить имя и значение перменной, в скобках вместо строки надо поставить
номер переменной (или индекс?).</font></font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Вставьте
следуюшую процедуру в окно Code, запустите проект, кликните на форме увидите
список всех переменных и их значений!</font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub</font><font color="#000000"> Form_Click()</font></font>
<br><font size="-1" color="#006600">&nbsp;
''берём переменную и присваиваем ей единицу</font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;
m = 1</font>
<br><font size="-1" color="#006600">&nbsp;
''запускаем цикл, который увеличивает переменную m каждый</font>
<br><font size="-1" color="#006600">&nbsp;
''раз на единицу и подсовывает её функции Environ</font>
<br><font size="-1" color="#000099">&nbsp;&nbsp;
Do</font>
<br><font size="-1"><font color="#000000">&nbsp;
</font><font color="#006600">''присваеваем
перменной EnvString возвращаемую перменную,</font></font>
<br><font size="-1" color="#006600">&nbsp;
''соответсвующую номеру m</font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;
EnvString = Environ(m)</font>
<br><font size="-1" color="#006600">&nbsp;
''печатаем перменную, соответсвующую номеру m</font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;
Print Environ(m)</font>
<br><font size="-1" color="#006600">&nbsp;
''перменную m увеличиваем на один</font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;
m = m + 1</font>
<br><font size="-1" color="#006600">&nbsp;
''если перменная EnvString всё ещё не пустая - крутим дальше...</font>
<br><font size="-1"><font color="#000099">&nbsp;&nbsp;
Loop Until</font><font color="#000000"> EnvString = ""</font></font>
<br><font size="-1" color="#000099">End
Sub</font></font>
</p><p><font color="#000000" face="Tahoma" size="-1">ТЕПЕРЬ
ВСЁ!&nbsp; И теперь все, кто недолюбливает API-функции (по-моему их
вообще мало, кто долюбливает)&nbsp; могут пользоваться только этой строчкой!</font>
</p><p><font face="Tahoma" size="2"><font color="#000000"><b> </b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>
</p><p>&nbsp;

<b>

<font face="Courier New,Courier">
</font></b></p><hr width="100%"><b>

</b>

<font face="Tahoma"><a name="#6"></a>Если нужно поменять значение переменной
<b> As Boolean</b>
на противоположное, то вместо процедуры:</font>
<p><font face="Tahoma"><font size="-1"><font color="#000099">If</font>
ABC <font color="#000099">Then</font></font>
<br><font size="-1">&nbsp;&nbsp; ABC = <font color="#000099">False</font></font>
<br><font size="-1"><font color="#000099">Else:</font>
ABC = <font color="#000099">True</font></font>
<br><font size="-1" color="#000099">End
If</font></font>
</p><p><font size="-1" face="Tahoma">можно использовать строку:</font>
</p><p><font size="-1" face="Tahoma">ABC = <font color="#000099">Not</font>
ABC</font>
</p><p><font size="-1" face="Tahoma">И тогда какое значение
не содержала бы переменная ABC, оно (значение) станет противоположным!</font>
</p><p><font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>


<br><br>

</p></font></td>
</tr>
</tbody>', 8, 13);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (29, 'О программах
', '<tbody><tr>
<td>
<br>

<h1 align="center">О программах</h1>

<a href="#1"><font color="#000000" size="2" face="Tahoma">Чтобы <b>EXE</b> не был запущен одновременно два раза</font></a>

<font color="#000000" face="Tahoma" size="2">
<br>

<a href="#2"><font color="#000000" size="2" face="Tahoma">Как</font></a></font>

<a href="#2">

<font color="#000000" face="Tahoma" size="-1">
 запустить на <b> VB5.0</b>
исходники, написанные на <b> VB6.0</b></font>
</a>
<br>

<font face="Tahoma" size="2"><a href="#3"><font color="#000000">Kак сделать,
чтобы программa перестала работать примерно
через 30 дней?</font></a>
</font>
<br>

<font face="Tahoma" size="2">
<a href="#4"><font color="#000000">Вызов различных программ</font></a></font>

<font size="-1">

<b>

<hr width="100%">

</b>

<font face="Tahoma"><a name="#1"></a>Чтобы Ваш EXE не был запущен одновременно два раза в
событие Form_Load впишите:</font>
<p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub </font>Form_Load()</font>
<br><font size="-1"><font color="#000099">If
</font>App.PrevInstance
= True <font color="#000099">Then</font></font>
<br><font size="-1">&nbsp;&nbsp; MsgBox
"Проект уже запущен!"</font>
<br><font size="-1">&nbsp;<font color="#000099">&nbsp;
End</font></font>
<br><font size="-1" color="#000099">End
If</font></font>
</p><p><font color="#000099" face="Tahoma">&nbsp;</font><font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font><font color="#000099">

<b>

</b></font></p><hr width="100%"><font color="#000099"><b>

</b>

</font>

<font face="Tahoma"><font color="#000000"><a name="#2"></a>Чтобы запустить на VB5.0
исходники, написанные на VB6.0 откройте файл проекта с расширением
VBP каким-нибудь текстовым редактором и удалите строки:</font></font><font face="Tahoma">
<br><font size="-1">Retained
= 0</font>
<br><font color="#000000" size="-1">DebugStartupOption
= 0</font></font>

</font><p><font size="-1"></font><font color="#000000" face="Tahoma" size="2"><b>&nbsp;</b></font>

<font size="-1">

<font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>

<b>

<font color="#000099">
</font></b></font></p><font size="-1"><b><font color="#000099">
<hr width="100%"></font>

</b>

</font>

<p><font color="#FF0000" face="Tahoma" size="2">&nbsp;
</font><font color="#000000" face="Tahoma" size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
<a name="#3"></a>
</p>

<font size="-1">

<p><font color="#000000" size="-1" face="Tahoma">Сделать
это очень просто. Сначала нужно либо записать в регистр либо куда-нибудь
в папку Windows в файл *.ini, например дату первого запуска. Потом при
каждом запуске нужно проверять разницу между текущей датой и датой первого
запуска. Например так:</font>
</p><p><font face="Tahoma" color="#000080">If</font><font color="#000000" face="Tahoma">
DateDiff("d", #11/8/99#, Date) &gt; 30 </font><font face="Tahoma" color="#000080">Then</font><font color="#000000" face="Tahoma">
...</font>
</p><p><font face="Tahoma" color="#008000">''если разница
между датой 11 августой 1999 года и текущей
<br>''в днях
больше 30, тогда ....</font>
</p><p><font color="#000000" face="Tahoma">А потом
можно просто закрыть программу и всё!</font>

</p></font><p><font size="-1">

</font>

<font color="#000000" face="Tahoma" size="2"><b>&nbsp;</b></font>

<font size="-1">

<font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>

<font color="#000099">

<b>

</b></font></font></p><hr width="100%"><font size="-1"><font color="#000099"><b>

</b>

</font>

</font>

<p><font color="#000099" face="Tahoma" size="2">&nbsp;</font>

<font size="-1">

<font color="#000099">
</font></font></p><p><font size="-1"><font color="#000099"><font size="2" face="Tahoma" color="#000000"><a name="#4"></a>Сделать
это очень просто! Всего лишь надо вызвать команду
<b> Shell</b>
с именем нужного файла. Например при нажатии кнопки
<b> Command1</b> должен запускать
калькулятор:</font>
</font></font></p><p><font size="-1"><font color="#000099"><font face="Tahoma" size="2"><font color="#000099">Private
Sub</font><font color="#000000"> Command1_Click()</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;</font><font color="#000099">
Call</font><font color="#000000"> Shell("c:\\windows\\calc.exe", vbNormalFocus)</font>
<br><font size="-1" color="#000099">End Sub</font></font>
</font></font></p><p><font size="-1"><font color="#000099"><font size="2" face="Tahoma" color="#000000">Константа,
стоящая после запятой - определяет вид окна программы. Конечно есть одна
проблема - как определить путь к тому или иному приложению на компьютере
пользователя? Стандартные программы от <b> Windows</b> всегда находятся в виндовском
каталоге. </font>

<b>

</b></font></font></p><p><font size="-1"><font color="#000099"><b>&nbsp;<font face="Tahoma" size="2"><a href="#B"><font color="#000000">Назад</font></a></font></b></font></font></p><font size="-1"><font color="#000099"><b>


<br><br>

</b></font></font></td>
</tr>
</tbody>', 8, 13);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (30, 'Текстовые строки
', '<tbody><tr>
<td>
<br>

<h1 align="center">Текстовые строки</h1>


<table border="0" width="880" bgcolor="#ffffff">

<tbody><tr>
<td>

<span lang="RU" style="mso-ansi-language:RU">
<font face="Tahoma" size="2">
<a href="#1"><font color="#000000">Отформатировать буквы в строке</font></a></font></span>
<br>


<span lang="RU" style="mso-ansi-language:RU">
<font face="Tahoma" size="2"><span style="mso-ansi-language: RU">
<a href="#2"><font color="#000000">Сравнение текстовых
строк</font></a>
<br>


<a href="#3"><font color="#000000">Сортировка</font></a>
</span></font></span>
<br>


<font face="Tahoma" size="2">
<a href="#4"><font color="#000000">Обработка слов</font></a>
<br>

<a href="#5"><font color="#000000">Kак сделать вывод только&nbsp; заглавных букв
в <b>TextBox</b></font></a><br>

<a href="#6"><font color="#000000">Ввод в <b>TextBox</b> только цифр</font></a>

</font>


<hr width="100%">





&nbsp; <font face="Tahoma" size="2">&nbsp;</font><font face="Tahoma" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2"><a name="#1"></a>Отформатировать буквы в строке</font></span>
<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Для
того, чтобы отформатировать буквы в строке
используется много разных способов. По-моему
наиболее удобен вот этот:</font></span><font face="Tahoma" size="2">&nbsp;<o:p>
</o:p>
</font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><b>NewString=StrConv(sString,
vbUpperCase)</b>&nbsp;<o:p>
</o:p>
</font></p>
<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Вместо</font></span><font face="Tahoma" size="2"><span lang="RU">
</span><span lang="RU" style="mso-ansi-language:RU">можно</span><span lang="RU">
</span><b>vbUpperCase</b> <span lang="RU" style="mso-ansi-language:RU">ставить</span><span lang="RU">
</span><b>vbLowerCase</b>, <b> vbProperCase</b><o:p>
 &nbsp;<o:p>
</o:p>
</o:p></font></p>
<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">В
проекте это выглядит так:<o:p>
</o:p></font></span><font face="Tahoma" size="2">&nbsp;<o:p>
</o:p>
</font></p>
<p class="MsoNormal"><font face="Tahoma" size="2" color="#000080">Option Explicit</font><font face="Tahoma" size="2"><o:p>
</o:p>
</font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><font color="#000080">Dim</font> sString
<font color="#000080"> As String<o:p>
 </o:p></font>

</font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><font color="#000080">Dim</font> NewString
<font color="#000080"> As String<o:p>
 </o:p></font>

</font></p>
<p class="MsoNormal"><font face="Tahoma" size="2">&nbsp;<o:p>
</o:p>
</font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><font color="#000080">Private Sub</font> Form_Click()<o:p>
</o:p>
</font></p>
<p class="MsoNormal"><font face="Tahoma" size="2">sString = Text1.Text<o:p>
</o:p>
</font></p>
<p class="MsoNormal"><font face="Tahoma" size="2">NewString = StrConv(sString,
vbUpperCase)<o:p>
</o:p>
</font></p>
<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">Text1.Text
= NewString<o:p>
</o:p>
</font></span></p>
<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2"><font color="#000080">End
Sub<o:p>
 </o:p></font>

</font></span></p>
<p class="MsoNormal"><span lang="RU" style="mso-ansi-language:RU">

</span><font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font></p>





<hr width="100%">


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Tahoma" size="-1">&nbsp;
<a name="#2"></a>Сравнение текстовых
строк</font>
<p>

<font size="-1">

<font face="Tahoma">Если Вы применяете в вашей программе сравнение текстовых
строк, то Вам будет полезно напоминание следующего:</font>
</font></p><font size="-1">
<ul>
<li>
<font size="-1" face="Tahoma" color="#000000">строки
одинаковые по содержанию, но различные по написанию будyт распознаны, как
неравные:</font></li>
</ul>

<center><font size="-1" face="Tahoma" color="#000000">"Visual
Basic" &lt;&gt; "Visual BASIC"</font></center>

<ul>
<li>
<font size="-1" face="Tahoma" color="#000000">если
же Вы хотите, чтобы сходство проходило по содержанию, а не по написанию,
то Вам придётся преобразовать обе строки к верхнему или нижнему регистру:</font></li>
</ul>

<center><font face="Tahoma"><font size="-1" color="#000000">UCase
("Visual Basic") = UCase ("Visual BASIC")</font>
<br><font size="-1">''"VISUAL
BASIC" = "VISUAL BASIC"</font>
<br><font size="-1">LCase
("Visual Basic") = LCase ("Visual BASIC")</font>
<br><font size="-1" color="#006600">''"visual
basic" = "visual basic"</font></font></center>

<ul>
<li>
<font size="-1" face="Tahoma" color="#000000">или
же поставить в General Declaration опцию Option Compare Text.
Программа будет тогда различать текст только по содержанию</font></li>
</ul>

<p><font face="Tahoma" color="#000000">&nbsp;</font><font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font></p>

&nbsp;

</font>

</td>

</tr>

<tr>
<td>

<p><font face="Tahoma" size="2"><font color="#000000">&nbsp;<a name="#3"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Сортировка</font></font>

</p><p><font face="Tahoma" size="2" color="#000080">Как
сделать сортировку, чтобы, когда компьютер сортировал, то первая буква
не сортировалась, пример: O1, O2, O3, O11, O12,&nbsp; компьютер сортирует,
как O1, O11, O12, O2. А как сделать, чтобы компьютер сортировал O1, O2,
O3, O11?</font><font color="#000000" face="Tahoma" size="2"><br>Подобные
вопросы, по чистому бэйсику, где нужно поломать голову над логической задачей
и проявить логическое мышление, я просто обожаю!</font>
</p><p><font size="2" face="Tahoma" color="#000000">Мне не
понятен способ сортировки, которым пользовался автор вопроса. Я же могу
предложить следующий:</font>
</p><p><font size="2" face="Tahoma" color="#000000">1.Поместите
где-нибудь процедуру Sort:</font>
</p><p><font face="Tahoma" size="2"><font color="#006600">''т.к. мы
не знаем сколько переметров нужно передать процедуре,</font>
<br><font color="#006600">''то на
это место устанавливаем массив, и аргументов можно переда-</font>
<br><font color="#006600">''ть теперь
сколько угодно!</font>
<br><font color="#000099">Sub Sort</font><font color="#000000">(</font><font color="#000099">ParamArray</font><font color="#000000">
a())</font></font>
</p><p><font face="Tahoma" size="2"><font color="#006600">''объявляем
три переменные</font>
<br><font color="#000099">Dim</font><font color="#000000">
X </font><font color="#000099">As Integer</font>
<br><font color="#000099">Dim</font><font color="#000000">
Y </font><font color="#000099">As Integer</font>
<br><font color="#000099">Dim
</font><font color="#000000">P
</font><font color="#000099">As
String</font></font>
</p><p><font face="Tahoma" size="2"><font color="#006600">''запускаем
первый цикл</font>
<br><font color="#000099">&nbsp;&nbsp;&nbsp; For</font><font color="#000000"> Y = 0 </font><font color="#000099">To
UBound</font><font color="#000000">(a)</font>
<br><font color="#006600">''запускаем
второй цикл</font>
<br><font color="#000099">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; For</font><font color="#000000"> X = 0 </font><font color="#000099">To
UBound</font><font color="#000000">(a)</font>
<br><font color="#006600">''меняем
местами значения:</font>
<br><font color="#006600">''если
переменная второго цикла больше переменнной первого,</font>
<br><font color="#006600">''то переменной
Р присваеваем значение переменной второго цикла,</font>
<br><font color="#006600">''самой
переменной присваеваем значение переменной первого цикла,</font>
<br><font color="#006600">''а переменной
первого цикла присваеваем значение переменной Р</font>
<br><font color="#006600">''Места
значений поменались!</font>
<br><font color="#000099">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
If</font><font color="#000000"> Val(a(X)) &gt; Val(a(Y)) </font><font color="#000099">Then</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
P = a(X)</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
a(X) = a(Y)</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
a(Y) = P</font>
<br><font color="#000099">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
End If</font></font>
</p><p><font size="2" face="Tahoma"><font color="#000099">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Next</font><font color="#000000"> X</font></font>
</p><p><font size="2" face="Tahoma"><font color="#000099">&nbsp;&nbsp;&nbsp; Next</font><font color="#000000"> Y</font></font>
</p><p><font face="Tahoma" size="2"><font color="#006600">''запускаем
новый цикл и перечисляем значения в новом порядке!</font>
<br><font color="#000099">&nbsp;&nbsp;&nbsp; For</font><font color="#000000"> Y = 0 </font><font color="#000099">To
UBound</font><font color="#000000">(a)</font>
<br><font color="#000099">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Debug.Print</font><font color="#000000"> a(Y)</font>
<br><font color="#000099">&nbsp;&nbsp;&nbsp; Next</font><font color="#000000"> Y</font></font>
</p><p><font size="2" face="Tahoma" color="#000099">End Sub</font>
</p><p><font size="2" face="Tahoma" color="#000000">Вот и всё!
Теперь осталось передать процедуре Sort аргументы:</font>
</p><p><font size="2" face="Tahoma" color="#000000">Sort "011",
"02", "012", "03", "01"</font>
</p><p>&nbsp;<font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font></p>

<p>&nbsp;</p>

</td>

</tr>

<tr>
<td>

<p><font color="#000099" face="Tahoma" size="2">&nbsp;<a name="#4"></a></font>
</p><p><font face="Tahoma" size="2"><font color="#000099">Как
например в текстовом поле (Text1) выбирать слова? Например в строке Text1
я написал "Очень люблю арбузы", тогда как сделать что-бы он по отдельности
обработал слова - "Очень". "люблю", и "арбузы".</font>
<br></font>
<font size="2" face="Tahoma" color="#000000">Сделать
это можно при помoщи всего трёх строк, но для начала создайте на форме
поле, где будет содержаться текст (Text1), маленькое поле, где будет находиться
слово(Text2), которое следует искать и кнопку для выполнения команды(Command1).
Теперь в событие клика по кнопке впишите:</font>
</p><p><font face="Tahoma" size="2"><font color="#000099">Private
Sub</font><font color="#000000"> Command1_Click()</font>
<br><font color="#006600">&nbsp;&nbsp; ''садим фокус в большое текстовое поле</font>
<br><font color="#000000">&nbsp;&nbsp; Text1.SetFocus</font>
<br><font color="#006600">&nbsp;&nbsp; ''устанавливаем начало выделения - для этого находим&nbsp;</font>
<br><font color="#006600">&nbsp;&nbsp; ''позицию первого символа слова, отнимаем единицу,</font>
<br><font color="#006600">&nbsp;&nbsp; ''чтобы было с начало слова, а не со второго символа</font>
<br><font color="#000000">&nbsp;&nbsp; Text1.SelStart = InStr(1, Text1.Text, Text2.Text) - 1</font>
<br><font color="#006600">&nbsp;&nbsp; ''длину выделения приравниваем длине искомого слова</font>
<br><font color="#000000">&nbsp;&nbsp; Text1.SelLength = Len(Text2.Text)</font>
<br><font size="-1" color="#000099">End Sub</font></font>
</p><p>&nbsp;<font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>
</p><p>&nbsp;

</p></td>

</tr>

<tr>
<td>

&nbsp;<p><font face="Tahoma" size="2" color="#FF0000">&nbsp;
</font><font face="Tahoma" size="-1"></font><font face="Tahoma" size="2" color="#FF0000">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font><font face="Tahoma" size="2"><a name="#6"></a>Ввод в <b>TextBox </b>только
цифр</font></p>
<pre><font face="Tahoma" size="2"><font color="#000080">Private Sub</font> Text1_KeyPress(KeyAscii <font color="#000080">As Integer</font>)&nbsp;<o:p>
</o:p> <font color="#000080">If</font> KeyAscii &lt; Asc(0) Or KeyAscii &gt; Asc(9) <font color="#000080">Then</font><span style="mso-ansi-language:RU">
 </span>KeyAscii<span lang="RU" style="mso-ansi-language:
RU"> = 0<o:p>
</o:p> </span>Beep<span lang="RU" style="mso-ansi-language:RU"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>'' </span>звуковой сигнал при ошибке<span lang="RU" style="mso-ansi-language:RU"><o:p>
</o:p></span> <font color="#000080">End If&nbsp;</font><o:p>
</o:p></font><font color="#000080" size="2" face="Tahoma"><span style="mso-bidi-font-size: 12.0pt; mso-fareast-font-family: Times New Roman; mso-bidi-font-family: Times New Roman; mso-ansi-language: EN-US; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">End Sub</span></font></pre>
<p><font face="Tahoma" size="2"><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>
</p><p>
<br>

</p></td>

</tr>

<tr>
<td>

&nbsp;
<p><font face="Tahoma" size="2" color="#FF0000">&nbsp;
</font><font face="Tahoma" size="-1"></font><font face="Tahoma" size="2" color="#FF0000">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font><font face="Tahoma" size="2"><a name="#5"></a>К</font><font face="Tahoma" size="2">ак
сделать вывод только&nbsp; заглавных букв в <b>TextBox</b></font></p>
<p><font face="Tahoma" size="2">Независимо от того
вводить в <b>Text1</b> заглавные или прописные
буквы все они становится<br>
заглавными.<br>
<br>
<font color="#000080">Private Sub</font> Text1_KeyPress(KeyAscii <font color="#000080">As
Integer</font>)</font></p>
<p><font face="Tahoma" size="2">Dim char<br>
char = Chr(KeyAscii)<br>
KeyAscii = Asc(UCase(char))</font></p>
<p><font face="Tahoma" size="2"><font color="#000080">End Sub</font></font></p>
<p><font face="Tahoma" size="2"><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>
</p><p>
<br>

</p></td>

</tr>
</tbody></table>

<br><br>

</td>
</tr>
</tbody>', 8, 13);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (31, 'Разные советы - Формы, окна
', '<tbody><tr>
<td>
<br>

<h1 align="center">Разные советы - Формы, окна</h1>

<span lang="RU" style="FONT-FAMILY: Tahoma; 
LAYOUT-GRID-MODE: line; mso-bidi-font-family: 
''Times New Roman''; mso-ansi-language: RU"><font face="Tahoma" size="2">
<a href="#1"><font color="#000000">Задержка формы на экране</font></a></font></span>
<br>


<font size="2" face="Tahoma">
<a href="#2"><font color="#000000">Форма с рамкой, но без заголовка</font></a>
<br>

<a href="#2"><font color="#000000">Активное окно в <b>MDI</b>-форме</font></a>
</font>

<hr width="100%">

<a name="#1"></a>
<b>&nbsp;<font face="Tahoma" size="2"></font></b><span lang="RU" style="font-family:Tahoma;
mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;layout-grid-mode:
line">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span lang="RU" style="FONT-FAMILY: Tahoma; LAYOUT-GRID-MODE: line; mso-bidi-font-family: ''Times New Roman''; mso-ansi-language: RU"><font face="Tahoma" size="2">Задержка
формы на экране.</font></span>
<p><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language: RU">При
загрузке стартовой формы, когда нужно ее
некоторое время задержать на экране, я
делаю это при помощи </span><b>API<span style="mso-ansi-language: RU">
</span></b><span lang="RU" style="mso-ansi-language: RU">- функции, а
не при помощи пустого цикла </span><b>For<span lang="RU" style="mso-ansi-language: RU">
... </span>Next</b><span lang="RU" style="mso-ansi-language: RU">. На
сколько я знаю, где-то вычитал, этот цикл</span>&nbsp;<span lang="RU" style="mso-ansi-language: RU">
загружает процессор , что мешает работать в
многозадачной среде, а функция </span><b>API</b><span lang="RU" style="mso-ansi-language: RU">
- нет.<br>
Делается это так :<o:p>
 </o:p>
</span></font></p>
<p class="MsoNormal"><font face="Tahoma" size="2"><span lang="RU" style="mso-ansi-language: RU"><br>
В модуле программы описываем <span style="mso-spacerun: yes">&nbsp;</span></span><b>API<span style="mso-ansi-language: RU">
</span></b><span lang="RU" style="mso-ansi-language: RU">- функцию<o:p>
 </o:p>
</span></font></p>
<p><font face="Tahoma" size="2"><span style="COLOR: blue; mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">Declare</span><span style="COLOR: blue; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">
</span><span style="COLOR: blue; mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">Sub</span><span style="COLOR: #3333ff; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">
</span><span style="mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">Sleep</span><span style="COLOR: #3333ff; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">
</span><span style="COLOR: #3333ff; mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">Lib</span><span style="COLOR: #3333ff; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">
</span><span lang="RU" style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">"</span><span style="mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">kernel</span><span lang="RU" style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">32"
(</span><span style="COLOR: #3333ff; mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">ByVal</span><span style="COLOR: #3333ff; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">
</span><span style="mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">milliseconds</span><span style="COLOR: #3333ff; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">
</span><span style="COLOR: #3333ff; mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">As</span><span style="COLOR: #3333ff; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">
</span><span style="COLOR: #3333ff; mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">Long</span><span lang="RU" style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">)<br>
</span><span style="mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">&nbsp;</span><span lang="RU" style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt"><br>
В </span><b><span style="mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">Form</span><span lang="RU" style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">_</span><span style="mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">Load</span><span style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">
</span></b><span lang="RU" style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">стартовой
формы пишем следующий код, где</span><span style="mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">&nbsp;</span><span style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">
</span><span style="mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt"><b>Form</b></span><span lang="RU" style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt"><b>1</b>
является стартовой. <o:p>
</o:p>
</span></font></p>
<p><font face="Tahoma" size="2"><span style="COLOR: #3366ff; mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">Private
Sub </span><span style="mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">Form_Load()<br>
<span style="COLOR: #3366ff">&nbsp; </span>Form1.Show<br>
&nbsp; DoEvents<br>
&nbsp; Sleep 2000<br>
&nbsp; Unload Form01<br>
&nbsp; MDIForm1.Show<br>
<span style="COLOR: #3366ff">End Sub</span> <o:p>
</o:p>
</span></font></p>
<p><font face="Tahoma" size="2"><b><span style="mso-bidi-font-family: Times New Roman; mso-bidi-font-size: 12.0pt">Sleep</span><span lang="RU" style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">
2000</span></b><span lang="RU" style="COLOR: #3366ff; mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">
</span><span lang="RU" style="mso-bidi-font-family: Times New Roman; mso-ansi-language: RU; mso-bidi-font-size: 12.0pt">-<span style="COLOR: #3366ff">
</span><span style="COLOR: black">дает задержку
приблизительно на 3-4 секунды.</span> <o:p>
</o:p>
</span></font></p>





<font face="Tahoma" size="2"><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a><b>&nbsp;
</b></font><span lang="RU" style="font-family:Tahoma;
mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;layout-grid-mode:
line">

</span>

<font size="-1">

<font face="Tahoma">&nbsp;</font>

<b>

<font color="#000000">
<hr width="100%"></font>

</b>
<a name="#2"></a>
<font face="Tahoma">Чтобы сделать форму с рамками, но без заголовка,
нужно изменить следующие её свойства:</font><font face="Tahoma">
<br><font size="-1">Caption = ""</font>
<br><font size="-1">ControlBox = False</font></font>
<p>

<font face="Tahoma" size="2"><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>

<b>

</b></p><hr width="100%"><b>

</b>
<a name="#3"></a>
<font face="Tahoma" size="-1">Работая с окном MDI, я сталкнулся со следующей проблемой: мне нужно было обратиться к активному окну, а так как создавал я их из ондого и того же, то и были они всего лишь элементами массивов. Приходилось вести индекс и считать их, присваевать тэгам их индексы и т.д. Вобщем СВЕРХнеудобно! Эх... как я долго мучился пока не заглянул в
Help. Сам совет: если Вам нужно обратиться к активному окну в окне-родителе MDI используйте ссылку на активную форму ActiveForm. Например:</font><p>

<font face="Tahoma" size="-1">

ActiveForm.Caption = "Я активное окно!"

</font>

</p></font><p><font size="-1">

<font face="Tahoma" size="-1">

И тогда неважно что там за окно будет активным, ему будет присвоен заголовок "Я активное окно!".&nbsp;

</font>

</font>

</p><p>

<font face="Tahoma" size="2"><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>


<br><br>

</p></td>
</tr>
</tbody>', 8, 13);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (32, 'Файлы
', '<tbody><tr>
<td>
<br>

<h1 align="center">Файлы</h1>

<font face="Tahoma" size="2">
<a href="#1"><font color="#000000">Как проигрывать файлы любого формата</font></a></font>
<br>        

<font face="Tahoma" size="2">
<a href="#2"><font color="#000000">Как&nbsp; встроить в форму существующий файл Еxcel</font></a></font>

<br><font face="Tahoma" size="2">
<a href="#3"><font color="#000000">Как автоматически создавать файлы</font></a></font>

<hr width="100%">


<font size="-1">
<a name="#1"></a>
<font size="-1" face="Tahoma">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Как проигрывать файлы любого формата</font>
<p><font face="Tahoma"><font size="-1" color="#006600">''объявляем
в разделе формы General Declarations&nbsp;</font>
<br><font size="-1" color="#006600">''следующую
API-функцию:</font>
<br><font size="-1"><font color="#000099">Private
Declare Function </font><font color="#000000">mciExecute </font><font color="#000099">Lib</font><font color="#000000">
"winmm.dll" _</font></font>
<br><font size="-1"><font color="#000000">(</font><font color="#000099">ByVal</font><font color="#000000">
lpstrCommand </font><font color="#000099">As String</font><font color="#000000">)</font><font color="#000099">
As Long</font></font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub</font><font color="#000000"> Command2_Click() </font><font color="#006600">''чтобы
воспроизвести файл</font></font>
<br><font size="-1"><font color="#000000">&nbsp;</font><font color="#000099">
Call</font><font color="#000000"> mciExecute("play d:\\SilentCikle\\05.mp3")</font></font>
<br><font size="-1" color="#000099">End
Sub</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub</font><font color="#000000"> Command1_Click() </font><font color="#006600">''чтобы
закрыть файл</font></font>
<br><font size="-1"><font color="#000000">&nbsp;
</font><font color="#000099">Call</font><font color="#000000"> mciExecute("close
d:\\SilentCikle\\05.mp3")</font></font>
<br><font size="-1" color="#000099">End
Sub</font></font>


</p><p>&nbsp;<font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>


</p><hr width="100%">

</font>

<font color="#000099" face="Tahoma" size="2">&nbsp;</font><font color="#000099">
<a name="#2"></a>
 </font>

<font color="#000000" face="Tahoma" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Как
лучше встроить в мою форму существующий файл Еxcel ? Закрывать, открывать,
работать с VBA.</font>
<p><font color="#000000" face="Tahoma" size="2">Встроить
в форму существующий файл Excel можно многими способами - всё зависит то
того, как Вы хотите видеть этот файл на своей форме? Поскольку точно это
не описано, то я понимаю, что содержимое файла должно отображаться на экране
и при желании редактироваться. Сделать это очень просто с помощью объекта
OLE:</font><font size="-1">
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000000">1.Создаём
стандартную форму.</font>
<br><font color="#000000">2.На ToolBox''e
выбираем инструмент OLE и создаём окно на форме.</font>
<br><font color="#000000">3.Как
только Вы отпустите мышку, тут же появится диалоговое окно "Insert Object"
(Ввести объект).</font>
<br><font color="#000000">4.Слева
выбираем CheckBox "Create from file" (Создать из файла) и выбирете
нужный файл. </font><font color="#FF0000">Настоятельно рекомендую создать
резеpвную копию вашего XLS-файла.</font>
<br><font color="#000000">5.Если
Вы хотели бы видеть в окне весь файл, то в свойствах окна OLE1 свойство
SizeMode установите равным 2 (AutoSize).</font>
<br><font color="#000000">6.Это
всё! Чтобы активизировать таблицу, кликните на неё два раза. На форме появится
меню, позволяющее редактировать файл.</font>
<br><font color="#000000">7. Чтобы
сохранить внесённые изменения создайте командную кнопку. Переименуйте имя
кнопки Command1 в cmdSaveToFile</font></font>
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000099">Private
Sub</font><font color="#000000"> cmdSaveToFile_Click()</font>
<br><font color="#006600">&nbsp;&nbsp;&nbsp; ''открываем файл, как двоичный</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;</font><font color="#000099">
Open</font><font color="#000000"> OLE1.SourceDoc </font><font color="#000099">For
Binary As</font><font color="#000000"> #1</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font><font color="#006600">&nbsp;&nbsp;&nbsp;
''сохраняем в файл</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OLE1.SaveToFile 1</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;</font><font color="#006600">&nbsp;&nbsp;&nbsp;
''закрываем файл</font>
<br><font color="#000099">&nbsp;&nbsp;&nbsp; Close</font><font color="#000000"> #1</font>
<br><font size="-1" color="#000099">End Sub</font></font>
</font></p><p><font size="-1"><font size="2" face="Tahoma" color="#000000">А в событие
Form_Load нужно вписать следующий код, чтобы при загрузке формы файл загружался
в созданный OLE-контейнер:</font>
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000099">Private
Sub</font><font color="#000000"> Form_Load()</font>
<br><font color="#006600">&nbsp;&nbsp;&nbsp; ''открываем файл, как двоичный</font>
<br><font color="#000000">&nbsp;
</font><font color="#000099">Open</font><font color="#000000">
OLE1.SourceDoc
</font><font color="#000099">For Binary As</font><font color="#000000">
#1</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;</font><font color="#006600">&nbsp;&nbsp;&nbsp;
''считываем мз файла</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OLE1.ReadFromFile 1</font>
<br><font color="#006600">&nbsp;&nbsp; ''закрываем файл</font>
<br><font color="#000000">&nbsp;&nbsp;</font><font color="#000099">&nbsp; Close</font><font color="#000000"> #1</font>
<br><font size="-1" color="#000099">End Sub</font></font>
</font></p><p><font size="-1"><font size="2" face="Tahoma" color="#000000">Важно:
при применении следующих процедур формат XLS-файла будет изменён и Вы
не сможете больше открыть и редактировать его с помощью
приложения Excel, а только
с помощью вашей программы!</font>
</font></p><p><font size="-1"><font size="2" face="Tahoma" color="#000000">Могу также
предложить второй способ использования существующего файла Excel в своей
форме:</font>
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000000">1.Создаём
стандартную форму.</font>
<br><font color="#000000">2.На ToolBox''e
выбираем инструмент OLE и создаём окно на форме.</font>
<br><font color="#000000">3.Как
только Вы отпустите мышку, тут же появится диалоговое окно "Insert Object"
(Ввести объект).</font>
<br><font color="#000000">4.Слева
выбираем CheckBox "Create from file" (Создать из файла)и выбирете
нужный файл, но не кликайте на ОК!</font>
<br><font color="#000000">5.Теперь
следует выбрать CheckBox либо "Link" (Ярлык), либо "Display As Icon" (Отображать
как символ). При выборе "Link" в окне OLE будет отображаться содержание
файла и при двойном клике будет открываться желаемый файл как обычно -
через Excel. При выборе "Display As Icon" на вашей форме будет также ярлык
к файлу, но в виде иконки.</font>
<br><font color="#000000">6.Чтобы
при загрузке отображалось каждый раз новое содержания файла в событие Form_Load
введите:</font></font>
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000099">Private
Sub</font><font color="#000000"> Form_Load()</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp; OLE1.Update</font>
<br><font size="-1" color="#000099">End Sub</font></font>

</font></p><p><font size="-1">

</font>

<font color="#000000" face="Tahoma" size="2"><b>&nbsp;</b></font><font size="-1">
<font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>

<b>

</b></font></p><hr><font size="-1"><b>

</b>

</font>
<a name="#3"></a>
<p><font color="#000099" face="Tahoma" size="2">&nbsp;</font><font face="Tahoma" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font><font color="#000099"><font size="-1"><font face="Tahoma" size="2">Необходимо
создавать</font></font><font size="-1" face="Tahoma"> </font></font><font color="#000099"> автоматом</font><font face="Tahoma" size="2">
каждый день log-file типа:</font>
<font face="Tahoma" size="2"> </font><font size="-1"><font face="Tahoma" size="2"><font color="#000099">20000102.log&nbsp;</font>
<br>
<br></font>
<font size="2" face="Tahoma" color="#000000">1.Установите
таймер, интервал 1000.</font>
</font></p><p><font size="-1"><font size="2" face="Tahoma" color="#000000">2. В таймер
пишите:</font>
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000099">If</font><font color="#000000">
Time = "00:00:00" Then </font><font color="#006600">'' если Вы в Америке,
то строка&nbsp;</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font><font color="#006600">''должна быть "0:00:00 AM"</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;
</font><font color="#000099">Open</font><font color="#000000"> Format(Date;
"yyyymmdd") &amp; ".log"</font><font color="#000099"> For Output As</font><font color="#000000">
#1</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font><font color="#000099">Print</font><font color="#000000"> #1, </font><font color="#006600">''теперь
печатаете в лог всё, что хотите...</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;
</font><font color="#000099">Close</font></font>

</font>

</p><p><font color="#000099" face="Tahoma" size="2">End If</font></p>
<p>

<b>

<font size="-1">&nbsp;

</font>

</b>

<font face="Tahoma" size="2"><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>


<br><br>

</p></td>
</tr>
</tbody>', 8, 13);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (33, 'Разные советы
', '<tbody><tr>
<td>
<br>

<h1 align="center">Разные советы</h1>

<font color="#000000" face="Tahoma" size="2">
<a href="#1"><font color="#000000">Список шрифтов в объекте
<b>ListBox</b></font></a></font>
<br>

<font color="#000000" face="Tahoma" size="-1">
<a href="#2"><font color="#000000">Невидимый
курсор</font></a>&nbsp;</font>
<br>


<font color="#000000" face="Tahoma" size="-1">
<a href="#3"><font color="#000000">Как пользоваться генератором случайных чисел</font></a>&nbsp;</font>


<hr width="100%">


<font size="-1">
<a name="#1"></a>
<font color="#000000" face="Tahoma">При помощи следующего
кода Вы можете получить список всех шрифтов на компьютере пользователя!
Для этого можно создать объект List1 и в событие Form_Load поместить:</font>
<p><font size="-1" face="Tahoma"><font color="#000099">Dim
</font><font color="#000000">m
</font><font color="#000099">As
Integer</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''запускаем
цикл, который повториться столько раз, сколько имеется</font>
<br><font size="-1" color="#006600">''шрифтов
минус один, т.к. счёт идёт от нуля</font>
<br><font size="-1"><font color="#000099">For</font><font color="#000000">
m = 0 </font><font color="#000099">To</font><font color="#000000"> Screen.FontCount
- 1</font></font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;
''в List1 добавляем элемент массива Screen.Fonts cоответсвующий числу m</font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;&nbsp;
List1.AddItem Screen.Fonts(m)</font>
<br><font size="-1" color="#000099">Next</font></font>
</p><p><font face="Tahoma" size="2"><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>

<b>

<font color="#000099">
</font></b></p><hr width="100%"><b>

</b>
<a name="#2"></a>
<font color="#000000" face="Tahoma">Хотите сделать ваш курсор
невидимым? Нет проблем! Впишите в раздел формы General Declarations следующий
код:</font>
<p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Declare Function</font><font color="#000000"> ShowCursor </font><font color="#000099">Lib</font><font color="#000000">
"User32" (</font><font color="#000099">ByVal</font><font color="#000000">
_</font></font>
<br><font size="-1"><font color="#000000">bShow
</font><font color="#000099">As
Long</font><font color="#000000">) </font><font color="#000099">As Long</font></font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Теперь
создайте две кнопки для прятания курсора и для показа и впишите в них следующий
код:</font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub</font><font color="#000000"> Command1_Click()</font></font>
<br><font size="-1" color="#000000">&nbsp;
a = ShowCursor(1)</font>
<br><font size="-1"><font color="#000000">&nbsp;
</font><font color="#000099">Do
While</font><font color="#000000"> a &gt;= 0</font></font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;&nbsp;
a = ShowCursor(0)</font>
<br><font size="-1"><font color="#000000">&nbsp;
</font><font color="#000099">Loop</font></font>
<br><font size="-1" color="#000099">End
Sub</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub</font><font color="#000000"> Command2_Click()</font></font>
<br><font size="-1" color="#000000">&nbsp;
a = ShowCursor(0)</font>
<br><font size="-1"><font color="#000000">&nbsp;
</font><font color="#000099">Do
While</font><font color="#000000"> a &lt; 0</font></font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;&nbsp;
a = ShowCursor(1)</font>
<br><font size="-1"><font color="#000000">&nbsp;</font><font color="#000099">
Loop</font></font>
<br><font size="-1" color="#000099">End
Sub</font></font>

</p><p><font face="Tahoma" size="2"><font color="#000000"><b>&nbsp;</b></font><a href="#B"><font color="#000000"><b>Назад</b></font></a></font>

</p><p>

<b>

</b></p><hr width="100%"><b>
</b>

</font>
<a name="#3"></a>
<p><font color="#000099" face="Tahoma" size="2">&nbsp;</font><font color="#000099"><font size="2" face="Tahoma">&nbsp;</font>&nbsp;&nbsp;&nbsp;
</font><font size="2" face="Tahoma" color="#000000">Как пользоваться генератором случайных чисел в VB. Числа в пределах 1-25,
1-100</font><font size="-1"><font face="Tahoma" size="2"><font color="#000099">&nbsp;</font>
<br></font>
</font></p><p><font size="-1"><font size="2" face="Tahoma" color="#000000">Для
генерации случайных чисел в VB используется оператор Rnd, который генерирует
числа от 0 до 1. Т.е. это могут быть числа : 0,3267545;
0,79563; 0,0043678
и т.д. Если же мы будем умножать генерируемое число на 10, то интервал
генерируемых чисел будет равняться уже от 0 до 10 (соответственно, если
умножать на сто, то интервал генерируемых чисел будет равняться уже от
0 до 100). И вышеназванные числа будут иметь следующий вид:
3,267545; 7,9563; 0,043678. Чаще
же всего нам нужны целые числа, без "хвостов". Для этого можно использовать
функцию Int(), которая возвращает значение типа, совпадающего с
типом аргумента, которое содержит целую часть числа. Расшифровываю: :))
функция Int() преобразует число в целое. Например:</font>
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000000">Int(3,267545)
= 3</font>
<br>Int(7,9563)
= 8
<br><font size="-1" color="#000000">Int(0,043678)
= 0</font></font>
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000000">А
теперь соберём всё вместе: итак, чтобы получить случайное число от нуля
до ста нужно</font>
<br><font color="#000000">1.Умножить
генерируемое число на сто: Rnd*100</font>
<br><font color="#000000">2.И
взять его целую часть: Int(Rnd*100).</font></font>
</font></p><p><font size="-1"><font size="2" face="Tahoma" color="#000000">Пример:</font>
</font></p><p><font size="-1"><font size="2" face="Tahoma"><font color="#000000">X
= Int(Rnd*100)</font><font color="#000099"> </font><font color="#006600">''получаем
Х - случайное число от 0 до 100</font></font>
</font></p><p><font size="-1"><font size="2"><font color="#FF0000" face="Tahoma">Внимание!!!
</font><font color="#000000" face="Tahoma">Ряд
"случайных" чисел будет каждый раз повторяться, если Вы не установите в
Form_Load инструкцию Randomize, которая инициализирует датчик случайных
чисел:</font>
</font>
</font></p><p><font size="-1"><font face="Tahoma" size="2"><font color="#000099">Private
Sub </font><font color="#000000">Form_Load ()</font>
<br><font color="#000000">&nbsp;&nbsp;&nbsp; Randomize</font>
<br><font size="-1" color="#000099">End
Sub</font></font>

<b>

</b></font></p><p><font size="-1"><b><font face="Tahoma" size="2"><font color="#000000">&nbsp;</font><a href="#B"><font color="#000000">Назад</font></a></font>


<br><br>

</b></font></p></td>
</tr>
</tbody>', 8, 13);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (34, 'Немного о DBGrig
', '<tr>
<td>
<br>

<h1 align="center">Немного о DBGrig</h1>

<font size="2" face="Tahoma">
</font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2">
<a href="#1"><font color="#000000">Немного
о<b> DBGrig</b></font></a></font></span>
        



<font face="Tahoma" size="4">
        



<hr width="100%">


<font face="Tahoma" size="2">
&nbsp;
</font><font size="2" face="Tahoma">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2"><a name="#1"></a>Немного
о<b> DBGrig&nbsp;</b></font></span>
<p><span lang="RU" style="mso-ansi-language:RU"><font face="Tahoma" size="2"><span style="mso-ansi-language: RU">Иногда
в ходе исполнения программы необходимо
сделать один из столбцов&nbsp; <b>DbGrid</b>&nbsp;
недоступным&nbsp; для редактирования (например
столбец содержащий счетчик). Для этого
используется следующий код: <o:p>
</o:p>
</span></font></span></p>
<p style="margin-top:0cm;margin-right:18.0pt;margin-bottom:
0cm;margin-left:18.0pt;margin-bottom:.0001pt"><span style="mso-ansi-language: RU" lang="RU"><font face="Tahoma" size="2">DBGrid1.Columns(0).Locked
= <font color="#000080"> True</font></font></span></p>
<p style="margin-top:0cm;margin-right:18.0pt;margin-bottom:
0cm;margin-left:18.0pt;margin-bottom:.0001pt">&nbsp;</p>
<span style="mso-ansi-language: RU" lang="RU"><font face="Tahoma" size="2"><span style="mso-ansi-language: RU">
Он
отключает возможность редактирования 1-ой
колонки.<o:p>
 </o:p></span>Или
можете временно ''погасить'' колонку:<o:p>
</o:p>
</font></span>
<p style="margin-top:0cm;margin-right:18.0pt;margin-bottom:
0cm;margin-left:18.0pt;margin-bottom:.0001pt"><span style="mso-ansi-language: RU" lang="RU"><font face="Tahoma" size="2">&nbsp;<o:p>
 &nbsp;<o:p>
</o:p>
</o:p></font></span></p>
<p style="margin-top:0cm;margin-right:18.0pt;margin-bottom:
0cm;margin-left:18.0pt;margin-bottom:.0001pt"><span style="mso-ansi-language: RU" lang="RU"><font face="Tahoma" size="2">DBGrid1.Columns(0).Visible
= <font color="#000080"> False</font></font></span><span style="font-family:Tahoma;
mso-bidi-font-family:&quot;Times New Roman&quot;"><o:p>
&nbsp;
</o:p></span></p>

<br><br>

</font></td>
</tr>', 8, 13);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (36, 'VB с азов. Для начинающего программиста
', '<tr>
<td>
<br>

<h1 align="center">VB с азов. Для начинающего программиста</h1>
<font face="verdana" size="2">


<center><b>VB или VBA?</b></center>

<br>Первый вопрос, который надо решить - собираетесь
Вы изучать VB или VBA? Те, кто собирается изучать Visual Basic иногда путают
эти два разных языка.&nbsp;
<br><b>Visual Basic</b> - компонент пакета <b>Visual Studio</b>. Язык,
позволяющий создавать самостоятельные приложения (программы) под Windows
95/98/NT. Приложения компилируются в машинные коды и распространяются в
виде exe-файлов. Для работы приложению требуется то или иное количество
компонентов и динамических библиотек, которые устанавливаются на машину
вместе с exe-файлом при инсталляции приложения программой Setup.&nbsp;
<br><b>VBA - Visual Basic for Application</b> - производный от VB, встроенный
в <b>MS Office</b> язык, позволяющий создавать макросы и функции для приложений
<b>Excel, Access, Word, Outlook, PowerPoint, Project, Binder</b> и работающий
только в среде этих приложений. Синтаксис, названия операторов и объектов
в обоих языках во многом совпадают. В обоих языках используется почти идентичная
среда разработки. Основные различия языков - это их возможности.&nbsp;
<br>Кроме того существует версия <b>Visual Basic Scripting Edition - VBScript</b>.
С помощью этой версии языка можно изготавливать приложения, встраиваемые
непосредственно в WEB-страницу.&nbsp;
<br>На страницах этого сайта речь в основном идет о языке VB 5.0&nbsp;

<center><b><p>С какой версии VB лучше начать?</p></b></center>

Лучше всего - начать сразу с VB6. Хотя некоторые
разработчики, перешедшие с VB5 и ворчат - но это старая как мир история...
К тому времени, как Вы доберетесь до этих "слабых" мест - они наверняка
будут обкатаны, исправлены и дополнены очередным Service Pack-ом. Что касается
литературы - пойдет все по предыдущей, пятой версии. Для инсталляции придется
найти CD-диски с Visual Studio.&nbsp;

<center><b><p>Что почитать?</p></b></center>

Для начала стоит просмотреть мой сайт, здесь много интересного для начинающих
много полезного для начала.
<br>Но чтением особо увлекаться не советую. Это занятие приносит ощутимую
пользу только в тесном соединении с практикой. Очень полезным может быть
изучение примеров (после инсталляции VB их можно найти в директории Sample)
и непосредственно программирование.&nbsp;
<br>А если Вы действительно всерьез возьметесь за VB, вооружитесь терпением
и по ходу первых программ читайте английский Help, никакие книжки этого
занятия не заменят.&nbsp;

<center><b><p>Как изучать?</p></b></center>

Могу поделиться вот таким приемом в освоении языка.
Для того, чтобы лучше понять свойства и методы объекта, а также каким образом
и что возвращается, можно поступать следующим образом.&nbsp;
<br>Например, для изучения свойств связанной с данными сетки DBGrid...&nbsp;
<br>Откройте новый проект, добавьте DBGrid к проекту (меню Project/Components),
поместите на форму. Разместите на форме также элемент Data, кнопку и несколько
элементов Label. Элемент DBGrid свяжите с элементом Data, элемент Data
по свойствам DatabaseName и RecordSource c любой имеющейся у Вас под рукой
базой данных формата Access (см. файлы с расширением mdb в примерах). А
теперь пишите для события Click кнопки код, примерно такого содержания
(зависит от того, какие свойства Вам интересны)&nbsp;
<br>Label1.Caption = "DBGrid1.ColumnHeaders " &amp; DBGrid1.ColumnHeaders&nbsp;
<br>Label2.Caption = "DBGrid1.Caption " &amp; DBGrid1.Caption&nbsp;
<br>Label3.Caption = "DBGrid1.Columns(1) " &amp; DBGrid1.Columns(1)&nbsp;
<br>Label4.Caption = "DBGrid1.Columns(3) " &amp; DBGrid1.Columns(3)&nbsp;
<br>Label5.Caption = "DBGrid1.Col " &amp; DBGrid1.Col&nbsp;
<br>Label6.Caption = "DBGrid1.Columns(3).DataField " &amp; DBGrid1.Columns(3).DataField&nbsp;
<br>Label7.Caption = "DBGrid1.Columns.Count " &amp; DBGrid1.Columns.Count&nbsp;
<br>передвигайте указатель по строкам DBGrid и смотрите на возвращаемые
значения. Разумеется подобные учебные проекты имеет смысл делать после
прочтения Help-а, для уточнения, все ли верно понято.&nbsp;

<center><b><p>Чем отличается версия VB5 Enterprise Edition 
от VB5 Professional Edition?</p></b></center>

В основном компонентами: VB5 Enterprise Edition
предназначен для разработки программного обеспечения коллективом
программистов и содержит пакет Visual SourseSafe (включая исходный код),
сохраняющий исходный текст программ в базе данных, отслеживающий номера
версий и позволяющий координировать действия отдельных разработчиков.
Так же VB5 Enterprise Edition содержит библиотеку объектов RDO версии 2.0
(Remote Data Objects - удаленного доступа к данным ), отладчик SQL -
транзакций  (T-SQL Debugger), Microsoft Transaction Server. Т.е. эта
редакция языка более ориентирована на создание ПО для крупных заказчиков,
корпораций, имеющих внутренние сети. Соответственно больше объем документации.


<center><b><p>Что такое *.ocx, как их использовать ?</p></b></center>

Вкратце, ocx - это чисто программный компонент ActiveX, в отличие
от ctl - элементов управления ActiveX, включающих графический интерфейс.
Использование ocx такое же как и у стандартных элементов управления
- помещаешь на форму, а затем используешь Property  и методы.
Как правило все они поставляются с примерами использования.<br><br>
Как обойтись без регистрации .ocx ,засорения с:\\windows\\system?
<br><br>
Регистрировать ocx-файлы можно в любом каталоге.
Но на мой взгляд все же в \\system удобнее - проще найти, особенно
если один и тот же файл используется многими проектами.
Что касается засорения - просто не надо забывать вовремя
разрегистрировать и удалять ненужное.
<br><br>
Как сделать, чтобы эти *.ocx или *.dll находились в одном каталоге c проектом?
<br><br>
Нет проблем на своей машине. Размещаешь в нужный каталог и
регистрируешь, например, утилитой ccrpRegUtil. Скачать ее можно с.   
<br><br>

</font></td>
</tr>', 8, 14);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (37, 'Новое в Visual Basic
', '<tbody><tr>
<td>
<br>

<h1 align="center">Новое в Visual Basic</h1>
<font face="verdana" size="2">

<b>Microsoft Visual Basic 6.0</b> является одним из наиболее эффективных средств для создания высокопроизводительных приложений, обладающих масштабируемостью до уровня предприятия и возможностью работы в Интернете.<p align="justify">
<img src="vbasic6.jpg" width="300" height="121" alt="Visual Basic, Visual, Basic, статьи, для новичков, примеры, программы, книги, уроки, разное, VB, введение, урок, Урок, что, такое, установка, настройка, этапы, структура, среда, работы, с кодом, массивы, записи, перечисления, выражения,  операторы, структуры, процедуры, функции, вместе, отладка, компиляция, заключение" border="1">
<br>Microsoft Visual Basic 6.0 содержит интегрированные средства визуальной работы с базами данных, поддерживающие проектирование и доступ к базам данных SQL Server, Oracle и др. К этим средствам относятся Visual Database Tools, ADO/OLE DB, Data Environment Designer, Report Designer и ряд других. 

Поддерживается создание серверных Web-приложений, работающих с любым средством просмотра на базе новых Web-классов. В новой версии также обеспечивается отладка приложений для IIS. В Microsoft Visual Basic 6.0 возможно создание интерактивных Web-страниц - оно подобно созданию обычной формы в VB. Для этого используется DHTML Page Designer.</p><p align="justify">

Microsoft Visual Basic 6.0 обеспечивает простое создание приложений, ориентированных на данные. Visual Basic 6.0 позволяет создавать клиент-серверные приложения, которые могут работать с любыми базами данных. Теперь Visual Basic 6.0 поддерживает универсальный интерфейс доступа к данным Microsoft при помощи технологии ActiveX Data Objects (ADO) версии 2.0.</p><p align="justify">

Для создания и отладки приложений масштаба предприятия рекомендуется использовать Microsoft SQL Server Developer Edition, масштабируемую производительную систему управления базами данных для систем под Windows NT. Visual Basic 6.0 обеспечит просмотр таблиц, изменение данных, создание запросов SQL из среды разработки для любой совместимой с ODBC или OLE DB базы данных. Интегрированный мастер создания баз данных поможет при разработке и изменении схем баз данных и других объектов Microsoft SQL Server 6.5+ и Oracle 7.3.3+. Используя мастер запросов, вы сможете визуально проектировать запросы и выполнять сложные операции с данными без необходимости изучения языка SQL.</p><p align="justify"> 

Создание, правка и интерактивная отладка хранимых процедур - все это выполняется прямо из среды Visual Basic. Так же как и в редакторе Visual Basic, синтаксис SQL выделяется цветом и незамедлительно проверяется на наличие ошибок. Это делает код SQL более легко читаемым и менее подверженным случайным ошибкам.</p><p align="justify"> 

Новая версия продукта поддерживает коллективную разработку, масштабируемость, создание компонентов промежуточного слоя, пригодных к многократному использованию в любом COM-совместимом продукте (например, Visual SourceSafe, Visual Modeler, BackOffice, Windows NT Option Pak).</p><p align="justify">

Технология IntelliSense позволяет увеличить скорость и производительность процесса разработки. Помимо этого среда разработки обладает множеством новых возможностей, таких как выделение синтаксиса и автоматическое завершение ключевых слов.</p><p align="justify"> 

Microsoft Visual Basic прекрасно интегрируется с семейством Microsoft BackOffice, которое обеспечивает среду для выполнения и создания сложных приложений масштаба предприятия для работы в локальных сетях или в Интернете.</p><p align="justify">

К основным характеристикам Microsoft Visual Basic 6.0 можно отнести:

</p><ul type="square"><li><p align="justify">Возможность быстрого создания эффективных приложений и компонентов в визуальной среде разработчика.</p><p align="justify">

</p></li><li><p align="justify">Возможность создания быстрых приложений и компонентов на уровне процессорного кода при использовании общей с Microsoft Visual C++ технологии компиляции. Приложения могут быть оптимизированы по скорости или по размеру, а также по многим другим параметрам, что позволяет еще больше увеличить их производительность.</p><p align="justify">

</p></li><li><p align="justify">Возможность создания многопоточных приложений и компонентов без необходимости ручного кодирования поддержки потоков.</p><p align="justify">

</p></li><li><p align="justify">Легкость создания компонентов COM, включая элементы ActiveX, а также компоненты среднего уровня и серверные компоненты.</p><p align="justify">

</p></li><li><p align="justify">Возможность воспользоваться навыками работы с Visual Basic при использовании Microsoft Office 97 и в приложениях, поддерживающих Microsoft Visual Basic Applications Edition.</p><p align="justify">

</p></li><li><p align="justify">Поддерживается быстрое создание форм данных, использование нового интегрированного мастера отчетов (Report Writer), и все это на основе технологии drag-and-drop.</p><p align="justify">

</p></li><li><p align="justify">Создание компонентов для доступа к данным с использованием новой среды данных (Data Environment) - для применения в разных проектах, в других средствах разработки или в Web.</p><p align="justify">

</p></li><li><p align="justify">Создание широкого спектра приложений для мобильных пользователей. </p><p align="justify">

</p></li><li><p align="justify">Достижение нового уровня производительности при работе с иерархическими данными с использованием улучшенного компонента FlexGrid, который позволит легко и удобно отображать связанные данные.</p><p align="justify">

</p></li><li><p align="justify">Использование новых интегрированных визуальных средств работы с данными облегчает выполнение рутинных задач по обеспечению доступа к ним; эти средства доступны прямо из среды разработки Visual Basic.</p><p align="justify">

</p></li><li><p align="justify">Возможность создания Web-приложений и компонентов, выполняемых на сервере Microsoft Internet Information Server, которые доступны из любого обозревателя на любой платформе.</p><p align="justify">

</p></li><li><p align="justify">Быстрое и легкое распространение приложений и компонентов при использовании мастеров пакетов и распространения.</p><p align="justify">

</p></li><li><p align="justify">Визуальное моделирование сложных приложений и интерфейсов компонентов в среде Visual Modeler. Visual Modeler генерирует код по созданным моделям и позволяет изменять и дополнять модели с последующей перегенерацией исходного кода.</p><p align="justify">

</p></li><li><p align="justify">Создание лучших решений на основе Windows NT Option Pack. Microsoft Transaction Server 2.0, Microsoft Internet Information Server 4.0 и Microsoft Message Queue Server позволят вам создавать сложные многопользовательские приложения для локальных сетей и для Web.</p></li></ul>

<p align="justify">

Свойства Visual Basic 6.0, особенно важные для разработчиков Web-содержания:</p><ul type="square">

<li><p align="justify">Расширение возможностей при использовании Dynamic HTML.</p><p align="justify">

</p></li><li><p align="justify">Возможности создания динамических форм, эффектов перехода, различных типографских эффектов, автоматического изменения размеров и многое другое.</p><p align="justify">

</p></li><li><p align="justify">Создание управляемых событиями страниц Dynamic HTML для работы в среде Microsoft Internet Explorer 4.0. Новый мастер Dynamic HTML Page Designer позволит вам создавать интерактивные страницы Web так же просто, как и формы в Visual Basic.</p><p align="justify">

</p></li><li><p align="justify">Легкость интеграции Web, включая страницы Dynamic HTML, в приложения Visual Basic при использовании компонента Internet Explorer 4.0 WebBrowser Control.</p></li></ul>           
     
<br><br>

</font></td>
</tr>
</tbody>', 8, 14);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (38, 'Логические операторы VB.
', '<tbody><tr>
<td>
<br>

<h1 align="center">Логические операторы VB.</h1>

<font face="verdana" color="#000000" size="2">
<br><font color="#000000"><font size="-1">В
Visual Basic можно выделить пять основных и важных логических операторов:
And, Or, Not, Xor и Eqv. Роль каждого из них я сейчас и попытаюсь объяснить!</font></font></font>
<p><font face="Tahoma"><font size="-1" color="#000000">Итак,
And!</font>
<br><font color="#000000"><font size="-1">Это,
наверное, самый простой и нужный логический оператор среди других.</font></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Help:</font>
<br><i><font color="#000000"><font size="-1">Возвращает
результат конъюнкции (логического И) для двух выражений.</font></font></i>
</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Синтксис:</font>
<br><font color="#000000" size="-1"><i>результат
= выражение1 </i><b>And</b><i> выражение2</i></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Т.е.
<i>результат</i>
будет истинным только в том случае, когда истинны <i>выражение1
</i><b>И</b><i>
выражение2. </i>Возвращаемые оператором значения представлены в следующей
таблице:</font>
<br>
</font>
<table border="" width="50%">
<tbody><tr>
<td align="center">
<center><b><font size="-1" face="Tahoma">выражение1&nbsp;</font></b></center>
</td>

<td align="center">
<center><b><font size="-1" face="Tahoma">выражение2&nbsp;</font></b></center>
</td>

<td align="center">
<center><b><font size="-1" face="Tahoma">результат</font></b></center>
</td>
</tr>

<tr>
<td align="center">
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma" color="#000099">True</font></center>
</td>
</tr>

<tr>
<td align="center">
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">False</font></center>
</td>
</tr>

<tr>
<td align="center">
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">Null</font></center>
</td>
</tr>

<tr>
<td align="center">
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">False</font></center>
</td>
</tr>

<tr>
<td align="center">
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">False</font></center>
</td>
</tr>

<tr>
<td align="center">
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">False</font></center>
</td>
</tr>

<tr>
<td align="center">
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">Null</font></center>
</td>
</tr>

<tr>
<td align="center">
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">False</font></center>
</td>
</tr>

<tr>
<td align="center">
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td align="center">
<center><font size="-1" face="Tahoma">Null</font></center>
</td>
</tr>
</tbody></table>

</p><p><font size="-1" face="Tahoma" color="#000000">А
теперь маленький пример:</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Представим
себе, что переменные User_Has_Computer и User_Has_Car объявлены как булевы
значения и в процессе каких-нибудь действий приняли значения либо True
либо False. Вы устанавливаете условие, проверяющие эти значения:</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Мы
же сэмулируем это сами :) - впишите куда - нибудь следующие строки:</font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font><font color="#000000">
User_Has_Computer </font><font color="#000099">As Boolean</font></font>
<br><font size="-1"><font color="#000099">Dim
</font><font color="#000000">User_Has_Car
</font><font color="#000099">As
Boolean</font></font>
<br><font size="-1"><font color="#000000">User_Has_Computer
= </font><font color="#000099">True</font></font>
<br><font size="-1"><font color="#000000">User_Has_Car
=</font><font color="#000099"> True</font></font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">If</font><font color="#000000">
User_Has_Computer </font><font color="#000099">And</font><font color="#000000">
User_Has_Car </font><font color="#000099">Then</font></font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;
MsgBox "Вы счастливый человек!"</font>
<br><font size="-1" color="#000099">End
If</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">При
проверки данного условия на экран выскочит сообщение, извещающие, что пользователь
счастливый человек, т.к. у него есть машинa <b>И</b> компьютер :-)! А теперь
перед третьей или четвёртой строкой поставьте апостроф "''" - закоменнтируйте
строку. Теперь одна из переменных будет False по умолчанию. Теперь сообщение
НЕ выскочит, т.к. пользователь не очень счастливый, имея машину <b>ИЛИ</b>
компьютер...</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Следующий
оператор не менее простой - Or.</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Help:</font>
<br><i><font color="#000000"><font size="-1">Выполняет
операцию логического ИЛИ (сложения) для двух выражений.</font></font></i>
</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Синтаксис:</font>
<br><font color="#000000" size="-1"><i>результат
= выражение1 </i><b>Or</b><i> выражение2</i></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Результат
будет истинным только в том случае, если только одно из выражений истинно.
Возвращаемые оператором значения представлены в следующей таблице:</font>
<br>&nbsp;</font>
<table border="" width="50%">
<tbody><tr>
<td>
<center><b><font size="-1" face="Tahoma">выражение1&nbsp;</font></b></center>
</td>

<td>
<center><b><font size="-1" face="Tahoma">выражение1&nbsp;</font></b></center>
</td>

<td>
<center><b><font size="-1" face="Tahoma">результат</font></b></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma" color="#000099">True</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma" color="#000099">True</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma" color="#000099">True</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma" color="#000099">True</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">Null</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma" color="#000099">True</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">Null</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">Null</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">Null</font></center>
</td>
</tr>
</tbody></table>

</p><p><font size="-1" face="Tahoma">И снова маленький пример
с прежними булевыми перменными <font color="#000000">User_Has_Computer
и User_Has_Car, которые в процессе каких-нибудь действий приняли значения
либо True либо False.</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font><font color="#000000">
User_Has_Computer </font><font color="#000099">As Boolean</font></font>
<br><font size="-1"><font color="#000099">Dim
</font><font color="#000000">User_Has_Car
</font><font color="#000099">As
Boolean</font></font>
<br><font size="-1"><font color="#000000">User_Has_Computer
= </font><font color="#000099">False</font></font>
<br><font size="-1"><font color="#000000">User_Has_Car
=</font><font color="#000099"> True</font></font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">If</font><font color="#000000">
User_Has_Computer Or User_Has_Car </font><font color="#000099">Then</font></font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;
MsgBox "Вы почти счастливый человек!"</font>
<br><font size="-1" color="#000099">End
If</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">При
проверки данного условия на экран выскочит сообщение, извещающие, что пользователь
почти счастливый человек, т.к. у него есть машинa, но нет компьютера :-|...</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Оператор
Not.</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Help:</font>
<br><i><font color="#000000"><font size="-1">Выполняет
над выражением операцию логического отрицания.</font></font></i>
</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Синтаксис:</font>
<br><font color="#000000" size="-1"><i>результат</i>
= <b>Not</b> <i>выражение</i></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Т.е.
<i>результат
</i>стаёт
противополжным <i>выражению</i> (исключая Null). Возвращаемые оператором
значения представлены в следующей таблице:</font>
<br>&nbsp;</font>
<table border="" width="50%">
<tbody><tr>
<td><b><font size="-1" face="Tahoma">выражение</font></b></td>

<td><b><font size="-1" face="Tahoma">результат</font></b></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma">True</font></td>

<td><font size="-1" face="Tahoma">False</font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma">False</font></td>

<td><font size="-1" face="Tahoma" color="#000099">True</font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma">Null</font></td>

<td><font size="-1" face="Tahoma">Null</font></td>
</tr>
</tbody></table>

</p><p><font size="-1" face="Tahoma">Пример:</font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Dim</font><font color="#000000">
User_Has_Computer </font><font color="#000099">As Boolean</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">User_Has_Computer
= </font><font color="#000099">False</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">If</font><font color="#000000">
</font><font color="#000099">Not</font><font color="#000000">
User_Has_Computer
</font><font color="#000099">Then</font></font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;
MsgBox "Сочувствую...:)"</font>
<br><font size="-1" color="#000099">End
If</font></font>
</p><p><font face="Tahoma"><font size="-1">Объясняю: условие If
... Then выполняется тогда, когда какое-нибудь выражение (на месте ...)
равно True. Представим, что переменная <font color="#000000">User_Has_Computer
= False. Тогда строка</font></font>
<br><font color="#000000"><font size="-1">Not
User_Has_Computer даёт результат True и условие выполняется!</font></font></font>
</p><p><font size="-1" face="Tahoma">Оператор Xor.</font>
</p><p><font face="Tahoma"><font size="-1">Help:</font>
<br><i><font size="-1">Выполняет операцию
исключающего ИЛИ для двух выражений.</font></i>
</font>
</p><p><font face="Tahoma"><font size="-1">Синтаксис:</font>
<br><font size="-1">[<i>результат</i> =]
<i>выражение1</i>
<b>Xor</b> <i>выражение2</i></font></font>
</p><p><font face="Tahoma"><font size="-1">В принципе, этот оператор
похож на Or, но это не просто <b>ИЛИ</b>, а исключающее <b>ИЛИ</b>. Если
одно и только одно из <i>выражений</i> истинно (имеет значение True), <i>результат</i>
имеет значение True. А оператор Or допускает два истинных <i>выражения</i>.
<i>Результат
</i>определяется следующим образом:</font>
<br>&nbsp;</font>
<table border="" width="50%">
<tbody><tr>
<td>
<center><b><font size="-1" face="Tahoma">выражение1</font></b></center>
</td>

<td>
<center><b><font size="-1" face="Tahoma">выражение2</font></b></center>
</td>

<td>
<center><b><font size="-1" face="Tahoma">результат</font></b></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma" color="#000099">True</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma" color="#000099">True</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>
</tr>
</tbody></table>

</p><p><font size="-1" face="Tahoma">Пример:</font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font><font color="#000000">
User_Has_Computer </font><font color="#000099">As Boolean</font></font>
<br><font size="-1"><font color="#000099">Dim
</font><font color="#000000">User_Has_Car
</font><font color="#000099">As
Boolean</font></font>
<br><font size="-1"><font color="#000000">User_Has_Computer
= </font><font color="#000099">False</font></font>
<br><font size="-1"><font color="#000000">User_Has_Car
=</font><font color="#000099"> True</font></font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">If</font><font color="#000000">
User_Has_Computer </font><font color="#000099">Xor</font><font color="#000000">
User_Has_Car </font><font color="#000099">Then</font></font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;
MsgBox "Вам нужна машина И компьютер!"</font>
<br><font size="-1" color="#000099">End
If</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Здесь
так же, как и в предыдущем примере условие выполняется только тогда, когда
строка User_Has_Computer </font><font color="#000099">Xor</font><font color="#000000">
User_Has_Car истинна (= True). А истинна она тогда и только тогда, когда
только одно из условие истинно. Если оба, то условие уже не исполнится.</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Оператор
Eqv.</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Help:</font>
<br><i><font color="#000000"><font size="-1">Используется
для проверки логической эквивалентности двух выражений.</font></font></i></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Синтаксис:</font>
<br><font color="#000000" size="-1"><i>результат</i>
= <i>выражение1</i> <b>Eqv</b> <i>выражение2</i></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Тут
совсем всё просто: результат будет истинным в том случае, если оба выражения
либо истинны, либо ложны. <i>Результат </i>определяется следующим образом:</font>
<br>&nbsp;</font>
<table border="" width="50%">
<tbody><tr>
<td>
<center><b><font size="-1" face="Tahoma">выражение1&nbsp;</font></b></center>
</td>

<td>
<center><b><font size="-1" face="Tahoma">выражение2</font></b></center>
</td>

<td>
<center><b><font size="-1" face="Tahoma">результат</font></b></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma" color="#000099">True</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">Flase</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">True</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>
</tr>

<tr>
<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma">False</font></center>
</td>

<td>
<center><font size="-1" face="Tahoma" color="#000099">True</font></center>
</td>
</tr>
</tbody></table>
</p><p><font size="-1" face="Tahoma" color="#000000">Пример:</font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font><font color="#000000">
User_Has_Computer </font><font color="#000099">As Boolean</font></font>
<br><font size="-1"><font color="#000099">Dim
</font><font color="#000000">User_Has_Car
</font><font color="#000099">As
Boolean</font></font>
<br><font size="-1"><font color="#000000">User_Has_Computer
= </font><font color="#000099">True</font></font>
<br><font size="-1"><font color="#000000">User_Has_Car
=</font><font color="#000099"> True</font></font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">If</font><font color="#000000">
User_Has_Computer </font><font color="#000099">Eqv</font><font color="#000000">
User_Has_Car </font><font color="#000099">Then</font></font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;
MsgBox "Вы или счастливый или несчастный человек!"</font>
<br><font size="-1" color="#000099">End
If</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Здесь
компьютер назовёт Вас человеком "счастливым или несчастным", т.к. условие
выполняется только тогда, когда пользователь имеет и машину и компьютер
или не того и не другого.</font>

<br><br>

</p></td>
</tr>
</tbody>', 8, 14);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (39, 'Массивы элементов управления
', '<tbody><tr>
<td>
<br>

<h1 align="center">Массивы элементов управления</h1>

<font face="verdana" color="#000000" size="2">
<br><font size="-1">Массив элементов управления
это группа идентичных элементов управления (командные кнопки, текстовые
поля и т.д.) имеющие общие процедуры обработки событий.</font>
<br><font size="-1">Работа с массивами элементов
управления требует меньших затрат на написание программы и придает ей большую
гибкость в работе.</font>
<br><font size="-1">Почти все элементы управления
(но только идентичные) могут организовываться в массивы.</font>
<br><font size="-1">На данный момент времени
существует два способа создания массива элементов управления:</font></font>
<ul>
<li>
<font size="-1" face="Tahoma">Создание массива элементов
управления во время разработки;</font></li>

<li>
<font size="-1" face="Tahoma">Создание массива элементов
управления во время выполнения программы;</font></li>
</ul>
<font size="-1" face="Tahoma">Рассмотрим процесс создания
массива элементов управления.</font>
<p><b><u><font size="-1" face="Tahoma">Создание массива
элементов управления во время разработки</font></u></b>
</p><p><font face="Tahoma"><font size="-1">Если Вам известно конкретное
количество тех или иных элементов управления, то будет целесообразней создать
их во время разработки. Сделать это очень просто.</font>
<br><font size="-1">Создаем на форме, к
примеру, элемент управления CommandButton1, убеждаемся, что он он выделен
и копируем его в буфер обмена (Ctrl+C). Далее выполняя операцию Ctrl+V,
получаем на форме еще один элемент управления CommandButton1. В результате
этих действий Вы создали массив элементов из двух командных кнопок! Теперь
внимательно просмотрите окно ‘Properties’, там Вы увидите,</font>
<br><font size="-1">что созданные командные
кнопки, которые отличаются друг от друга только своим индексом. Index -
это то свойство, которое позволяет элементам управления организовываться
в массивы. Открыв окно кода, Вы увидете, что несмотря на то, что на форме
находятся две командные кнопки, в разделе Object присутствует только –
Command1. Выбрав ее Вы попадете в процедуру обработки события</font>
<br><font size="-1">Click, обратите внимание,
что в данном случае процедура содержит аргумент Index. Аргумент Index указывает
на индекс того элемента управления, для которого сгенерировано событие.</font>
<br><font size="-1">Если Вы следовали описанию
и создали на форме командные кнопки, то впишите следующий код в процедуру
обработки Click и Вам станет ясно как это работает.</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub</font> Command1_Click (Index As Integer)</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;
''В заголовке формы отображаем индекс нажатой кнопки</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;
Me.Caption = "Нажата кнопка с индексом - " &amp; Index</font>
<br><font size="-1" color="#000099">End
Sub</font></font>
</p><p><b><u><font size="-1" face="Tahoma">Создание массива
элементов управления во время выполнения программы</font></u></b>
</p><p><font size="-1" face="Tahoma">Если Вам заранее не известно
количество тех или иных элементов управления, которое необходимо будет
создать, то не волнуйтесь, т.к. и это очень просто. Создаем на форме, к
примеру, элемент управления CommandButton1, в окне ‘Properties’ для свойства
Index устанавливаем значение 0 (нуль). В результате выполненых Вами действий
создается массив элементов управления с одним элементом. Для создания последующих
элементов управления (в данном случае командных кнопок) Вам необходимо
будет ввести соответствующий код в процедуру обработки события выполнении
при которой должен (или должны) возникнуть новые элементы управления. В
данном случае мы вставляем код в процедуру обработки события Form_Load
формы.</font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub</font> Form_Load ()</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp;<font color="#006600">
''Создаем новую командную кнопку в существующий массив</font></font>
<br><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;
Load Command1(1)</font>
<br><font size="-1">&nbsp;&nbsp;<font color="#006600">&nbsp;
''Размещаем ее там, где Вам необходимо...</font></font>
<br><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;
Command1(1).Top = Command1(0).Top + Command1(0).Height</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;
Command1(1).Left = Command1(0).Left</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;
''Делаем новую кнопку видимой</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;
Command1(1).Visible = True</font>
<br><font size="-1" color="#000099">End
Sub</font></font>
</p><p><font face="Tahoma"><font size="-1">Вот и все !</font>
<br><font size="-1">Если Вы следовали описанию
и создали на форме командные кнопки, то впишите следующий код в процедуру
обработки Click и Вам станет ясно как это работает.</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub</font> Command1_Click (Index As Integer)</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;
''В заголовке формы отображаем индекс нажатой кнопки</font>
<br><font size="-1">&nbsp;&nbsp; Me.Caption
= "Нажата кнопка с индексом - " &amp; Index</font>
<br><font size="-1">End
Sub</font>

<br><br>

</font></p></td>
</tr>
</tbody>', 8, 14);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (40, 'Переменные
', '<tbody><tr>
<td>
<br>

<h1 align="center">Переменные</h1>


<br><font color="#000000"></font>
<p><font size="-1" face="Tahoma" color="#000000">Итак,
переменная представляет собой временное хранилище для данных в вашей программе.
Кто учился информатике в школе, наверное, помнит, что "переменные - это
такие ящички в которых содержится информация...". В тексте программы Вы
можете использовать сколько угодно перменных. Особая польза от них - это
то, что Вы присваеваете нужным данным короткий и легкозапоминающийся идентификатор.
Ярлычок, так сказать. Согласитесь, если Вы присвоете переменной UserName
значение "Иванов Пётр Автагенович", то в дальнейшем использовать восемь
символов легче, чем двадцать три!!! Переменные могут содержать практически
любую информацию.</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Чтобы
грамотно использовать переменную, нужно её сначала объявить, зарезервировать
под неё память. Для этого используются следующие ключевые слова: Dim,
Private,
Public,
Static,
Global. Надеюсь ничего не забыл.</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Переменные
можно объявлять на уровне модуля и на уровне процедуры. Под уровнем модуля
подразумевается часть формы General и стандартный модуль, а под уровнем
процедуры подразумевается Sub, Function и т.д.</font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Пояснение
использования </font><font color="#000099">Static</font><font color="#000000">.
Описывает переменные только на уровне процедуры. Переменная, описанная
на уровне процедуры, "живёт" только в пределах этой процедуры на протяжении
работы приложения.</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Пояснение
использования </font><font color="#000099">Dim</font><font color="#000000">.
Описывает переменные как на уровне модуля так и на уровне процедуры. Переменная,
описанная на уровне процедуры, живёт только в пределах этой процедуры и
прекращает работу по оканчанию процедуры. Её мы чаще всего и применяем
как счётчик, т.к. он и нужен то нам всего в данной процедуре. Переменная,
описанная на уровне модуля, доступна для всех процедур данного модуля.
Т.е. если Вам нужна переменная, котороую видят все функции и процедуры,
тo и объявите её со словом </font><font color="#000099">Dim
</font><font color="#000000">на
уровне модуля.</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Пояснение
использования </font><font color="#000099">Public</font><font color="#000000">.
Описывает переменные на уровне модуля. Таким образом переменная стаёт глобальной,
но на уровне формы и доступна всем остальным модулям. Вот вопрос из конференции:</font></font>
</p><p><i><font size="-1" face="Tahoma" color="#000099">Описываю
переменную Public в разделе формы General, присваиваю ей значение, при
переходе в другую форму значение становится Null, что же это за глобальность?
работаю в VB 5.0. Посоветуйте.</font></i>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Конечно,
при переходе в другую форму переменная будет пустой, неизвестной для второй
формы! Чтобы избежать этого нужно объявить переменную в стандартном модуле
со словом </font><font color="#000099">Public </font><font color="#000000">или
</font><font color="#000099">Global</font><font color="#000000">.
Тогда переменная будет доступна и известна КАЖДОЙ форме.</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Пояснение
использования </font><font color="#000099">Private</font><font color="#000000">.
Описывает переменные как на уровне модуля так и на уровне процедуры. Переменная,
описанная на уровне процедуры, живёт только в пределах этой процедуры.
Переменная, описанная на уровне модуля, доступна лишь модулю, в котором
она объявлена.</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Объявление
всех переменных считается хорошей привычкой. В помощь забывчивым и незабывчивым
есть инструкция </font><font color="#000099">Option Explicit</font><font color="#000000">.
Привыкайте использовать её всегда! Помещать эту инструкцию нужно на уровне
модуля и потом она проверяет каждую переменную объявлена ли она или нет?
Если нет - выскакивает ошибка.</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Допустимые
значения имён переменных:</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Abc;&nbsp;&nbsp;&nbsp;
Interstate76;&nbsp;&nbsp;&nbsp; MyDate;&nbsp;&nbsp;&nbsp; Eto_prawilnoe_imya_peremennoj;&nbsp;&nbsp;&nbsp;
Imya_peremennoj</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Недопустимые
значения имён переменных:</font>
</p><p><font size="-1" face="Tahoma"><font color="#FF0000">Name</font><font color="#000000">
- слово, зарезервированное VB</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#FF0000">8kilo</font><font color="#000000">
- в начале стоит число</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#FF0000">How
To</font><font color="#000000"> - состоит из двух слов.</font></font>
</p><p><font size="-1" face="Tahoma" color="#FF0000">A_eto_ne_prawilnoe_imya_peremennoj_tak_kak_ono_soderjit_bolee_soroka_simwolow</font>
</p><p><font size="-1" face="Tahoma" color="#000000">- имя
переменной содежит более сорока символов.</font>
</p><p><font size="-1" face="Tahoma"><font color="#FF0000">Ram&amp;Rom
</font><font color="#000000">-
содержит в середине символ &amp;</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Значения
переменным присваюваются следующим образом:</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Counter
= 13</font>
</p><p><font size="-1" face="Tahoma" color="#000000">или</font>
</p><p><font size="-1" face="Tahoma" color="#000000">MyName
= "C.M."</font>
</p><p><font size="-1" face="Tahoma" color="#000000">или</font>
</p><p><font size="-1" face="Tahoma" color="#000000">DateOfBird
= #06-06-99#</font>
</p><p><font size="-1" face="Tahoma" color="#000000">или</font>
</p><p><font size="-1" face="Tahoma" color="#000000">X =
Y + Z</font>
</p><p><font size="-1" face="Tahoma" color="#000000">или</font>
</p><p><font size="-1" face="Tahoma" color="#000000">X =
X - 1</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Вот
здесь некоторые математики войдут в заблуждение: "Как переменная икс может
равнятся своему значению, уменьшеному на единицу???". Объясняю: в этом
случае переменной икс присваевается значение её самой, уменьшеной на единицу.
Т.е. оператор "=" в этом случае не "равно", а <i>оператор присвоения</i>!</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Теперь
о типах переменных. При объявлении лучше всего объявить переменную, тем
самым указать сколько памяти нам потребуется:</font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Dim</font><font color="#000000">
uName </font><font color="#000099">As String</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">В этом
случае мы объявляем строковую переменную. Необяъвленная переменная автоматически
стаёт типом </font><font color="#000099">Variant</font><font color="#000000">.</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Размер
отводимой памяти под переменную зависит от вида этой переменной. Основные
виды переменных:</font>
<br>&nbsp;</font>
<table border="" width="100%">
<tbody><tr>
<td><b><font size="-1" face="Tahoma">Тип данных</font></b></td>

<td><b><font size="-1" face="Tahoma">Размер</font></b></td>

<td><b><font size="-1" face="Tahoma">Диапазон значений</font></b></td>

<td><b><font size="-1" face="Tahoma">Пример использования</font></b></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma"><font color="#000099">Interger</font>
(Целое)</font></td>

<td><font size="-1" face="Tahoma">2 байта</font></td>

<td><font size="-1" face="Tahoma">от -32 768 до 32 767</font></td>

<td><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font>
Bird%</font>
<br><font size="-1">Bird% = 37</font></font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma"><font color="#000099">Long
Integer </font>(Длинное целое)</font></td>

<td><font size="-1" face="Tahoma">4 байта</font></td>

<td><font size="-1" face="Tahoma">от -2 147 483 648 до
2 147 483 647</font></td>

<td><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font>
Loan&amp;</font>
<br><font size="-1">Loan&amp; = 350,000</font></font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma"><font color="#000099">Single</font>
- precision Floating point (Одинарной точности с плавающей десятичной точкой)</font></td>

<td><font size="-1" face="Tahoma">4 байтa</font></td>

<td><font size="-1" face="Tahoma">от -3.402823E38 до 3.402823E38</font></td>

<td><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font>
Price!</font>
<br><font size="-1">Price! = 899.99</font></font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma"><font color="#000099">Double</font>
- precision Floating point (Двойной точности с плавающей десятичной точкой)</font></td>

<td><font size="-1" face="Tahoma">8 байт</font></td>

<td><font size="-1" face="Tahoma">от -1.79769313486232D308
до 1.79769313486232D308</font></td>

<td><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font>
Pi#</font>
<br><font size="-1">Pi# = 3.1415926535</font></font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma"><font color="#000099">Currency</font>
(Денежные единицы)</font></td>

<td><font size="-1" face="Tahoma">8 байт</font></td>

<td><font size="-1" face="Tahoma">от -922337203685477.5808
до 922337203685477.5807</font></td>

<td><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font>
Debt@</font>
<br><font size="-1">Debt@ = 7600300.50</font></font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma"><font color="#000099">String</font>
(Строка)</font></td>

<td><font size="-1" face="Tahoma">1 байт на символ</font></td>

<td><font size="-1" face="Tahoma">от 0 до 65 535 символов</font></td>

<td><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font>
Dog$</font>
<br><font size="-1">Dog$ = "pointer"</font></font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma"><font color="#000099">Boolean</font>
(Логический)</font></td>

<td><font size="-1" face="Tahoma">2 байт</font></td>

<td><font size="-1" face="Tahoma">True (Истина) или False
(Ложь)</font></td>

<td><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font>
Flag As Boolean</font>
<br><font size="-1">Flag = True</font></font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma"><font color="#000099">Date</font>
(Дата)</font></td>

<td><font size="-1" face="Tahoma">8 байт</font></td>

<td><font size="-1" face="Tahoma">от January (Январь)1, 100,
до December (Декабрь) 31, 9999</font></td>

<td><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font>
Birthday As Date</font>
<br><font size="-1">Birthday =#3-1-63#</font></font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma"><font color="#000099">Variant</font>
(Вариант)</font></td>

<td><font size="-1" face="Tahoma">16 байт (для чисел); 22
байт на символ (для строк)</font></td>

<td><font size="-1" face="Tahoma">для всез типов данных</font></td>

<td><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font>
Total</font>
<br><font size="-1">Total = 289.13</font></font></td>
</tr>
</tbody></table>

</p><p><font size="-1" face="Tahoma">Также пользователь может
создавать свои собственные типы данных! Нужно это, например, если у Вас
есть группа элементов, связанных по смыслу. Создаётся он с помощью ключевого
слова Type. Для начала пример. Вы пишите программу
для какого-нибудь магазина, где артикль, дата поступления и, например,
срок годности поступаемого товара должны вводиться в компьютер и, соответсвенно,
присваиваться переменным. Для этого нам нужны как минимум три переменные.
Назовём их</font>
</p><p><font size="-1" face="Tahoma">Artikl - артикль</font>
</p><p><font size="-1" face="Tahoma">DatPos - дата поступления</font>
</p><p><font size="-1" face="Tahoma">SrokGod - строк годности.</font>
</p><p><font size="-1" face="Tahoma">Для этого можно просто создать
тип переменной, содержащий все три значения! Делается это так (в модуле):</font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''образовываем
тип переменной Towar и устанавливаем эти компоненты:</font>
<br><font size="-1"><font color="#000099">Type
</font>Towar</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; Artikl
<font color="#000099">As
String</font><font color="#006600">''aртикль (название) товара</font></font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; DatPos
<font color="#000099">As
Date&nbsp;&nbsp;&nbsp;&nbsp; </font><font color="#006600">''дата поступления</font></font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; SrokGod
<font color="#000099">As
Integer </font><font color="#006600">''срок годности пусть будет в месяцах
;-)</font></font>
<br><font size="-1" color="#000099">End
Type</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''теперь,
например, например для всех сортов колбасы</font>
<br><font color="#006600"><font size="-1">''объявляем
переменную:</font></font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Dim</font><font color="#000000">
Kolbasa </font><font color="#000099">As</font><font color="#000000"> Towar</font></font>
</p><p><font size="-1" face="Tahoma" color="#006600">''и
присваеваем значения (для этого после слова Kolbasa ставим точку!):</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Kolbasa.Artikl
= "Докторская"</font>
<br><font size="-1">Kolbasa.DatPos
= #04-08-99#</font>
<br><font size="-1" color="#000000">Kolbasa.SrokGod
= 12</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Ну,
вот пожалуй и всё!</font>

<br><br>

</p></td>
</tr>
</tbody>', 8, 14);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (41, 'Что такое API?
', '<tbody><tr>
<td>
<br>

<h1 align="center">Что такое API?</h1>

<font face="verdana" color="#000000" size="2">
<br><font size="-1" color="#000000">API
- это сокращение от Application Programming Interface. В общем каждая программа,
операционная система и т.д. имеет свой API. Windows - API состоит из целого
ряда функций, которые позволяют Вам использовать системные Windows-конструкции.
Все Windows-API-функции были написаны в C++, но ваши программы смогут спокойно
их использовать из Visual Basic''a. API-функции должны быть обязательно
продекларированы! Декларация API-функций имеет следующий синтаксис:</font></font>
<p><b><font color="#000099" size="-1" face="Tahoma">[Public
| Private] Declare Function</font></b>
<font size="-1" face="Tahoma">
<i>name</i><b><font color="#000099">
Lib </font></b><i>"libname"</i> [<b><font color="#000099">Alias</font></b>
<i>"aliasname"</i>]
[([<i>arglist</i>])] [<b><font color="#000099">As</font></b><i> type</i>]</font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000000">Ключевое
слово</font><font color="#CCFFFF"> </font><b><font color="#000099">Lib</font></b><font color="#CCFFFF">
</font><font color="#000000">указывает,
в какой библиотеке Visual Basic может найти нужную функцию. Имеются в виду
<i>библиотеки
динамических связей
</i>(*.dll). Но в <i>aliasname</i></font><i><font color="#CCFFFF">
</font></i><font color="#000000">указывать
расширение не надо. </font><b><font color="#000099">Alias</font></b> у<font color="#000000">казывает
под каким именем программа должна искать заданую функцию в библиотеке.</font><font color="#CCFFFF">
</font><font color="#000099">Arglist</font><font color="#CCFFFF">
-</font><font color="#000000"> это передаваемые параметры.Windows-API позволяет
две вещи: проведение определённых заданий и доступ к системным ресурсам.
Список различных API-функций и их деклараций Вы можете просмотреть при
помощи стандартной программы API-Viewer.</font></font>
<br>
</font>
</p><hr width="100%">
<font face="Tahoma">
<br><b><font size="-1" color="#FF0000">Примечание:
Если АPI-функция ждёт от вас переменной, Вы должны <u>обязательно</u> объявить
её и заполнить пробелами. Т.е. переменная должна быть определённой пользователем.
Это черты языка С++, на котором и был написан Windows-API.</font></b>
<br>
</font>
<hr width="100%">
<font face="Tahoma">
<br><font color="#000000"><font size="-1">Рассмотрим
пару примеров:</font></font></font>
<p><font size="-1" face="Tahoma"><font color="#000000">Допустим,
ваше приложение должно определять каталог, в котором установлена операционная
система Windows 95/98/NT. Сделать это проще всего, использовав API-функцию</font><font color="#CCFFFF">
</font><font color="#000099">GetWindowsDirectory</font><font color="#CCFFFF">.</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">1.
В модуле декларируем API-функцию</font><font color="#CCFFFF">
</font><font color="#000099">GetWindowsDirectory</font><font color="#CCFFFF">:</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Declare
Function</font><font color="#CCFFFF">
</font><font color="#000000">GetWindowsDirectory</font><font color="#CCFFFF">
</font><font color="#000099">Lib</font><font color="#CCFFFF">
</font><font color="#000000">"kernel32"</font><font color="#CCFFFF">
</font><font color="#000099">Alias
_</font></font>
<br><font size="-1"><font color="#000000">"GetWindowsDirectoryA"</font><font color="#CCFFFF">
</font><font color="#000000">(</font><font color="#000099">ByVal
</font><font color="#000000">lpBuffer</font><font color="#CCFFFF">
</font><font color="#000099">As
String</font><font color="#000000">, </font><font color="#000099">ByVal
_</font></font>
<br><font size="-1"><font color="#000000">nSize</font><font color="#CCFFFF">
</font><font color="#000099">As
Long</font><font color="#000000">)</font><font color="#CCFFFF">
</font><font color="#000099">As
Long</font></font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">2.
В модуле объявляем переменную, допустим, WinDir, которой должно быть присвоено
имя директории.</font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Public</font><font color="#CCFFFF">
</font><font color="#000000">WinDir
</font><font color="#000099">As
String</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">3.
В подпрограмму</font><font color="#CCFFFF">
</font><font color="#000000">вписываем:</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''Переменную,
которую надо передать API, мы уже</font>
<br><font size="-1" color="#006600">''объявили
и теперь заполняем пробелами.</font>
<br><font size="-1" color="#006600">''
Пробелов должно быть примерно столько,</font>
<br><font size="-1" color="#006600">''сколько
примерно символов должна иметь переменная.</font>
<br><font size="-1" color="#006600">''В
этом случае хватит и 20, т.к. Windows обычно устанавливают в</font>
<br><font size="-1" color="#006600">''
С:\\Windows или C:\\Win95, и т.д. Т.е. сумма символов, скорее</font>
<br><font size="-1" color="#006600">''
всего не превысит 20</font>
<br><font size="-1">WinDir
= Space(20)</font>
<br><font size="-1"><font color="#000099">Debug.Print
</font><font color="#000000">Left(WinDir,
GetWindowsDirectory(WinDir, 20))</font></font>
<br><font size="-1" color="#006600">''Т.к.
API является функцией, то она должна возвращать какое-то</font>
<br><font size="-1" color="#006600">''значение.
В данном случае функция GetWindowsDirectory возврашает</font>
<br><font size="-1" color="#006600">''длину
искомого значения. Т.е. если, например, искомое значение</font>
<br><font size="-1" color="#006600">''
это C:\\WINDOWS, то функция вернёт значение 10.</font>
<br><font size="-1" color="#006600">''Переменная
же имеете длину 20. Эти 10 символов записываются</font>
<br><font size="-1" color="#006600">''первыми,
а дальше идут 10 пробелов. Зачем нам, спрашивается,</font>
<br><font size="-1" color="#006600">''лишние
10 символов? Ведь это используется ненужная память...</font>
<br><font size="-1" color="#006600">''Поэтому
инструкцией Left мы из переменной WinDir вытаскиваем</font>
<br><font color="#006600"><font size="-1">''ровно
столько первых символов, сколько вообще нужных...</font></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Второй
пример:</font>
<br><font size="-1"><font color="#000000">Например,
ваша программа должна определить какой из ваших носителей есть CD-ROM или
удалённый и т.д. "Родной" инструментарий Visual Basic''a сделать этого не
позволяет - приходится прибегать к помощи API-функции </font><font color="#000099"></font><font color="#CCFFFF">.</font></font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">1.
В модуле декларируем API-функцию </font><font color="#000099">GetDriveType</font><font color="#CCFFFF">:</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Declare
Function</font><font color="#CCFFFF">
</font><font color="#000000">GetDriveType</font><font color="#CCFFFF">
</font><font color="#000099">Lib</font><font color="#CCFFFF">
</font><font color="#000000">"kernel32"</font><font color="#CCFFFF">
</font><font color="#000099">Alias
_</font></font>
<br><font size="-1"><font color="#000000">"GetDriveTypeA"</font><font color="#CCFFFF">
</font><font color="#000000">(</font><font color="#000099">ByVal
</font><font color="#000000">nDrive</font><font color="#CCFFFF">
</font><font color="#000099">As
String</font><font color="#000000">)</font><font color="#CCFFFF"> </font><font color="#000099">As
Long</font></font>
<br><font size="-1" color="#006600">''Под
параметром nDrive подрзумевается, буква латинского</font>
<br><font color="#006600"><font size="-1">''алфавита
плюс двоетечие, т.е. потенциальное имя дисковода, например C:</font></font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">2.
В подпрограмму&nbsp; вписываем:</font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''здесь
цикл For...Next "подсовывает" функции GetDriveType все буквы</font>
<br><font size="-1" color="#006600">''латинского
алфавита по очереди. Функция Chr преобразовывает значения</font>
<br><font size="-1" color="#006600">''таблицы
ASCII (от 0 до 255) в буквы. Так вот 65 это буква A, a 90 это Z</font>
<br><font size="-1"><font color="#000099">Dim</font><font color="#CCFFFF">
</font><font color="#000000">myDrive</font><font color="#CCFFFF">
</font><font color="#000099">As
Integer</font></font>
<br><font size="-1"><font color="#000099">For</font><font color="#CCFFFF">
</font><font color="#000000">myDrive
= 65 </font><font color="#000099">To</font><font color="#CCFFFF">
</font><font color="#000000">90</font></font>
<br><font size="-1"><font color="#000099">Debug.Print</font><font color="#CCFFFF">
</font><font color="#000000">Chr(myDrive)
&amp; ":" &amp; " - " &amp; GetDriveType(Chr(myDrive) &amp; ":")</font></font>
<br><font size="-1" color="#000099">Next</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">&nbsp;Вот
что возвратит функция GetDriveType нам, например у меня:</font>
<br><font size="-1">A:
- 2</font>
<br><font size="-1">C:
- 3</font>
<br><font size="-1">D:
- 3</font>
<br><font size="-1">E:
- 5</font>
<br><font color="#000000"><font size="-1">Все
остальные буквы помечены цифрой 1. Да, что бы понять эти обозначения нужно
знать следующую таблицу:</font></font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Имя
константы:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Значение:</font>
<table border="" width="50%">
<tbody><tr>
<td><font size="-1" face="Tahoma" color="#000000">DRIVE_UNKNOWN</font></td>

<td><font size="-1" face="Tahoma" color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0</font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma" color="#000000">DRIVE_NO_ROOT_DIR</font></td>

<td><font size="-1" face="Tahoma" color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1</font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma" color="#000000">DRIVE_REMOVEABLE</font></td>

<td><font size="-1" face="Tahoma" color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2</font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma" color="#000000">DRIVE_FIXED</font></td>

<td><font size="-1" face="Tahoma" color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
3</font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma" color="#000000">DRIVE_REMOTE</font></td>

<td><font size="-1" face="Tahoma" color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
4</font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma" color="#000000">DRIVE_CDROM</font></td>

<td><font size="-1" face="Tahoma" color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
5</font></td>
</tr>

<tr>
<td><font size="-1" face="Tahoma" color="#000000">DRIVE_RAMDISK</font></td>

<td><font size="-1" face="Tahoma" color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
6</font></td>
</tr>
</tbody></table>

</p><p>
</p><hr width="100%">
<font face="Tahoma">
<font size="-1" color="#000000">Подпрограмма
<b>Main</b>
в модуле является как Form_Load на форме, т.е. считается главной и загружается
по умолчанию. </font>
</font>
<hr width="100%">
<font face="Tahoma">
<font color="#000000" size="-1">О
предназначениях многих API функций можно легко догадаться по их названию.
Например, GetWindowsDirectory (получить директорию Windows) или GetDriveType
(получить тип носителя).
</font></font>

<br><br>

</td>
</tr>
</tbody>', 8, 14);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (42, 'Для чего нужна процедура Function?
', '<tbody><tr>
<td>
<br>

<h1 align="center">Для чего нужна процедура Function?</h1>

<font face="Tahoma">
<br><font size="-1">Итак, функция. Что это такое?
Функция выполняет служебное действие, например вычисление, и возвращает
значение. Вызвать функцию можно, написав её имя и передав ей аргументы,
в нужном месте вашей программы. Чем же полезна функция? Сейчас объясню на
очень простом примере! Например, Вы пишите простенькую программу, которая
вычисляет среднее арифметическое трёх чисел, потом умножает полученный
результат на каждое число и отнимает их сумму. Неважно зачем вам такая
программа, это ведь пример ;-). Вот она (пишем в модуле):</font></font>
<p><font size="-1" face="Tahoma"><font color="#000099">Sub</font>
Main()</font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font>
a <font color="#000099">As Integer&nbsp;&nbsp; </font><font color="#006600">''объявляем
переменную для первого числа</font></font>
<br><font size="-1"><font color="#000099">Dim</font>
b <font color="#000099">As Integer&nbsp;&nbsp; </font><font color="#006600">''объявляем
переменную для второго числа</font></font>
<br><font size="-1"><font color="#000099">Dim</font>
c <font color="#000099">As Integer&nbsp;&nbsp; </font><font color="#006600">''объявляем
переменную для третьего числа</font></font></font>
</p><p><font face="Tahoma"><font size="-1">a = InputBox("Введите первое
число") <font color="#006600">''получаем первое число</font></font>
<br><font size="-1">b = InputBox("Введите второе
число") <font color="#006600">''получаем второе число</font></font>
<br><font size="-1">c = InputBox("Введите третье
число") <font color="#006600">''получаем третье число</font></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''проделываем
нужную операцию над числами</font>
<br><font size="-1" color="#006600">''выводим
результат на экран</font>
<br><font size="-1">MsgBox (((((a + b + c) /
3) * a) * b) * c) - (a + b +c)</font></font>
</p><p><font size="-1" face="Tahoma" color="#000099">End
Sub</font>
</p><p><font face="Tahoma"><font size="-1">Вроде бы всё нормально. А
теперь представте себе, что программа начала ширится и формулой приходится
пользоваться из разных мест программы и Вы должны поэтому её кругом писать
8:-O !!!</font>
<br><font size="-1">Да, некрасиво получается...
Для этого можно воспользоваться функцией, которая будет иметь эту формулу
и только ждать своего вызова и ваших чисел ;-)! Напишем такую функцию и
назовём её, например FuncX (вне пределов подпрограммы Sub):</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''объявляем
функцию и задаём передаваемые аргументы</font>
<br><font size="-1"><font color="#000099">Public</font>
<font color="#000099">Function</font>
FuncX(a, b, c) <font color="#000099">As Integer</font></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''присваевает
себе значение формулы</font>
<br><font size="-1">FuncX = (((((a + b + c)
/ 3) * a) * b) * c) - (a + b + c)</font></font>
</p><p><font size="-1" face="Tahoma" color="#000099">End
Function</font>
</p><p><font size="-1" face="Tahoma">Есть! А теперь Вы можете
вызывать функцию из <u>любого</u> места вашей программы, написав её имя
и передав три числа a, b и с:</font>
</p><p><font size="-1" face="Tahoma">FuncX (a, b, c)&nbsp; или
FuncX(4, 5, 6)</font>
</p><p><font size="-1" face="Tahoma">и не надо больше этой длинной
формулы! Вместо</font>
</p><p><font size="-1" face="Tahoma">(((((a + b + c) / 3) * a)
* b) * c) - (a + b +c)</font>
</p><p><font size="-1" face="Tahoma">Теперь можно писать</font>
</p><p><font size="-1" face="Tahoma">FuncX(a, b, c)</font>
</p><p><font size="-1" face="Tahoma">Неправда это удобней? Надеюсь
я обьяснил понятно ;)?</font>
</p><hr width="100%">
  <font face="Tahoma">
<br><b><font color="#FF0000"><font size="-1">Примечание:
передаваемые значения функции изменяются! Напрмер:</font></font></b>
  </font>
<p><font size="-1" face="Tahoma"><font color="#000099">Function</font><font color="#000000">
ABC (X,Y)</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">ABC
= (2 * X) + (2 * Y)</font>
</p><p><font size="-1" face="Tahoma" color="#000099">End
Function</font>
</p><p><b><font color="#FF0000" size="-1" face="Tahoma">Теперь
X равно 2 * Х, а Y равно 2 * Y, т.е. их значения удвоились. Для того чтобы
переданные значения не изменялись то в скобках нужно писать перед аргументом</font></b><font size="-1" face="Tahoma"><font color="#000099">
ByVal</font><b><font color="#FF0000">. Например:</font></b></font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Function</font><font color="#000000">
ABC ( </font><font color="#000099">ByVal</font><font color="#000000"> X,
</font><font color="#000099">ByVal</font><font color="#000000">
Y)</font></font>
</p><p><b><font color="#FF0000" size="-1" face="Tahoma">Сами
того не подозревая, мы очень часто используем функции. Например </font></b><font size="-1" face="Tahoma"><font color="#000000">InputBox</font><b><font color="#FF0000">.
Смотрите:</font></b></font>
</p><p><font size="-1" face="Tahoma" color="#000000">A =
InputBox (Prompt, Title)</font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">А </font><b><font color="#FF0000">-
это результат, возвращаемый функцией. </font></b><font color="#000000">InputBox
</font><b><font color="#FF0000">-
это&nbsp; имя функции.</font></b><font color="#000000"> Prompt и Title
</font><b><font color="#FF0000">-
передаваемые значения. Но функция это стандартна.</font></b></font>

<br><br>

</p></td>
</tr>
</tbody>', 8, 14);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (43, 'Для чего нужна процедура Sub?
', '<tbody><tr>
<td>
<br>

<h1 align="center">Для чего нужна процедура Sub?</h1>

<font face="Tahoma">
<br><font size="-1">Если Вы уже читали моё объяснения
процедуры Function, то Вы поймёте Sub ёще быстрее! В общем так, Sub это
то же самое, что и Function, только она не возвращает значение, а производит
какое-нибудь действие. Например вывод на экран сообщения или манипулирование
несколькими свойствами. Например
MsgBox. Это тоже подпрограмма. Например:</font></font>
<p><font size="-1" face="Tahoma">Msgbox ("Привет!", ,"Заголовок")</font>
</p><p><font size="-1" face="Tahoma">Msgbox - это имя подпрограммы.
А "Привет!" и "Заголовок" это передаваемые значения. Т.е. подпрограмма
Msgbox выводит окно на экран с текстом "Привет!" и заголовком "Заголовок".</font>
</p><p><font size="-1" face="Tahoma">Теперь допустим, что Вам
нужно, чтобы ваша программа вырезала из передаваемых строк все заданные
символы (возьмём мой пример из "Практики"):</font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Sub</font>
Main()</font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''объявляем
переменную для строки</font>
<br><font size="-1"><font color="#000099">Dim</font>
Stroka <font color="#000099">As String</font></font>
<br><font size="-1" color="#006600">''объявляем
переменную для символа, который надо вырезать</font>
<br><font size="-1"><font color="#000099">Dim</font>
Symbol <font color="#000099">As String</font></font>
<br><font size="-1" color="#006600">''объявляем
переменную для места нахождения символа</font>
<br><font size="-1"><font color="#000099">Dim
</font><font color="#000000">ReturnNumber</font>
<font color="#000099">As
Integer</font></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''получаем
строку, по умолчанию стоит строка</font>
<br><font size="-1" color="#006600">''"There
is nothing impossible!"</font>
<br><font size="-1">Stroka = InputBox("Введите
строку", , "There is nothing impossible!")</font>
<br><font size="-1" color="#006600">''получаем
символ, по умолчанию стоит символ "i"</font>
<br><font size="-1">Symbol = InputBox("Введите
символ", , "i")</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''запускаем
цикл</font>
<br><font size="-1" color="#000099">Do</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;
''с помощью InStr получаем местоположение искомого символа</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;
''если оно равно нулю, покидаем цикл</font>
<br><font size="-1">&nbsp;&nbsp; <font color="#000000">ReturnNumber</font>
= InStr(1, Stroka, Symbol):
<font color="#000099">If</font>
_</font>
<br><font size="-1"><font color="#000000">&nbsp;&nbsp;
ReturnNumber</font> = 0 <font color="#000099">Then</font>
<font color="#000099">Exit
Do</font></font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;
''строке присваем все символы слева до искомого и справа</font>
<br><font size="-1">&nbsp;&nbsp; Stroka = Left(Stroka,
<font color="#000000">ReturnNumber </font>- 1) + Right(Stroka, _</font>
<br><font size="-1">&nbsp;&nbsp; Len(Stroka)
- <font color="#000000">ReturnNumber</font>)</font></font>
</p><p><font size="-1" face="Tahoma" color="#000099">Loop</font>
</p><p><font size="-1" face="Tahoma">&nbsp;&nbsp;&nbsp; MsgBox
Stroka <font color="#006600">''выводим отредактированную строку на экран</font></font>
</p><p><font size="-1" face="Tahoma" color="#000099">End
Sub</font>
</p><p><font face="Tahoma"><font size="-1">А теперь представте, что
эти строки Вам нужны более одного раза и в разных местах !</font>
<br><font size="-1">Не проще ли&nbsp; написать
подпрограмму, которая это делает и потом просто вызывать её? Так, пишем
(вне модуля):</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Public
Sub</font> RemSym(Stroka, Symbol)</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; <font color="#000099">Do</font></font>
<br><font size="-1"><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ReturnNumber</font> = InStr(1, Stroka, Symbol): If _</font>
<br><font size="-1"><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ReturnNumber</font> = 0 Then Exit Do</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Stroka = Left(Stroka, <font color="#000000">ReturnNumber </font>- 1) +
Right _</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(Stroka, Len(Stroka) - <font color="#000000">ReturnNumber</font>)</font>
<br><font size="-1">&nbsp;<font color="#000099">&nbsp;&nbsp;
Loop</font></font>
<br><font size="-1">MsgBox Stroka</font>
<br><font size="-1" color="#000099">End
Sub</font></font>
</p><p><font size="-1" face="Tahoma">Вот так, а теперь можно просто
вызывать эту подпрограмму и передать значения строки и символа:</font>
</p><p><font size="-1" face="Tahoma">RemSym Stroka, Symbol</font>
</p><p><font size="-1" face="Tahoma">и из любого места!</font>

<br><br>

</p></td>
</tr>
</tbody>', 8, 14);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (44, 'О пользе циклов
', '<tbody><tr>
<td>
<br>

<h1 align="center">О пользе циклов</h1>

<font face="Tahoma">

<br><font color="#000000"><font size="-1">Расскажу
немного о циклах. Ведь <u>почти</u> не одна, даже очень простенькая программа,
не обходится без циклов. Циклы позволяют выполнить одну или несколько строк
кода несколько раз. Visual Vasic поддерживает следующие конструкции:</font></font></font>
<ul>
<li>
<a href="#Do...Loop"><font size="-1" face="Tahoma" color="#000000">Do...Loop</font></a></li>

<li>
<a href="#For...Next"><font size="-1" face="Tahoma" color="#000000">For...Next</font></a></li>

<li>
<a href="#ForEach...Next"><font size="-1" face="Tahoma" color="#000000">For
Each...Next</font></a></li>
</ul>
<b><font size="-1" face="Tahoma" color="#000000">Конструкция&nbsp;<a name="Do...Loop"></a>Do...Loop.</font></b>
<p><font size="-1" face="Tahoma" color="#000000">Этот
цикл используют в том случае, если Вам самим неизвестно сколько раз должен
быть исполнен набор инструкций. Например вот короткая программа, которая
просто считывает весь текст из файла:</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">1.
Создайте на диске с: какой-нибудь текстовый файл (желательно несколько
строк), допустим text.txt.</font>
<br><font size="-1" color="#000000">2.
Впишите в модуль:</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Sub</font><font color="#000000">
Main()</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''объявляем
переменную, которая принимает строки</font>
<br><font size="-1"><font color="#000099">Dim</font><font color="#000000">
Linia </font><font color="#000099">As String</font></font>
<br><font size="-1" color="#006600">''объявляем
переменную, которая будет содержать весь текст</font>
<br><font size="-1"><font color="#000099">Dim</font><font color="#000000">
AllText </font><font color="#000099">As String</font></font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Open</font><font color="#000000">
"c:\\text.txt"</font><font color="#000099"> For Input As</font><font color="#000000">
#1 </font><font color="#006600">''открываем файл text.txt для чтения</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">'' !!!
запускаем цикл, который длится до тех пор, пока</font>
<br><font color="#006600"><font size="-1">''
не будет достигнут конец файла <u>EOF</u> ( <u>E</u>nd <u>O</u>f <u>F</u>ile)
!!!</font></font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Do
Until</font><font color="#000000"> EOF(1)</font></font>
<br><font size="-1"><font color="#000000">&nbsp;Line
Input #1, Linia </font><font color="#006600">''вводим линию за линией в
переменную Linia</font></font>
<br><font size="-1" color="#006600">&nbsp;''записываем
каждую новою линию + переход на новую строку</font>
<br><font size="-1" color="#000000">&nbsp;AllText
= AllText + Linia + Chr(13) + Chr(10)</font>
<br><font size="-1" color="#000099">Loop</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Close</font><font color="#000000">
#1 </font><font color="#006600">''закрываем файл</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">MsgBox
AllText </font><font color="#006600">''выводим на экран сообщение</font></font>
</p><p><font size="-1" face="Tahoma" color="#000099">End
Sub</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Это
пример показал, что программист не знает КОГДА наступит конец файла, но
задал условие прекратится как только конец файла будет достигнут. Теперь
о том, как можно работать с этим циклом.</font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Во-первых,
можно создавать конструкции со словами </font><font color="#000099">Until</font><font color="#000000">
и </font><font color="#000099">While</font><font color="#000000">:</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Do
</font><font color="#000000">[</font><font color="#000099">Until</font><font color="#000000">
| </font><font color="#000099">While</font><font color="#000000">] <i>условие</i></font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Если
установленно ключевое слово </font><font color="#000099">While</font><font color="#000000">,
то цикл будет запускаться до тех пор, пока условие истинно, а </font><font color="#000099">Until</font><font color="#000000">
"крутит" цикл пока условие ложно. Сейчас объясню. В нашем примере стоит</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Do
Until</font><font color="#000000"> EOF(1)</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">т.е.
пока EOF(1) =</font><font color="#000099"> False </font><font color="#000000">цикл
работает. Другими словами строки считываются пока НЕ достигнут конец файла.
Можно поставить вместо этого это:</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Do
While Not </font><font color="#000000">EOF(1)</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Теперь
работа цикла ничуть не изменится. Ведь мы хоть и поменяли условие, но цель
оставили прежней! </font><font color="#000099">Not </font><font color="#000000">EOF(1)
значит что EOF(1) ложно, конец файла не достигнут. А так как </font><font color="#000099">While</font><font color="#000000">
работает только тогда, когда условие ложно, то цикл продолжает работать!</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Во-вторых,
эти ключевые слова можно менять местами и ставить можно как в начало цикла:</font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Do
</font><font color="#000000">[</font><font color="#000099">Until</font><font color="#000000">
| </font><font color="#000099">While</font><font color="#000000">] <i>условие</i></font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">так
и&nbsp; в конец цикла</font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Loop</font><font color="#000000">
[</font><font color="#000099">Until</font><font color="#000000"> | </font><font color="#000099">While</font><font color="#000000">]<i>
условие</i></font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Разница
состоит в том, что цикл может исполниться хотя бы один раз или не исполнится
вообще. В нашем случае слово </font><font color="#000099">Until </font><font color="#000000">стоит
в начале, значит если файл окажется пустым, то тут же будет достигнут конец
файла, условие сразу станет ложным и цикл тут же перестаёт работать! Попробуйте
теперь взять и перенести слова </font><font color="#000099">Until</font><font color="#000000">
EOF(1) на один пробел от </font><font color="#000099">Loop</font><font color="#000000">.
Запустите проект. Ага!!! Ошибка! Знаете почему? Потому что оператор </font><font color="#000099">Line
Input</font><font color="#000000"># пытается считать строку в то время
как конец файла уже достигнут. Цикл упустил этот момент, т.к. засечь он
его может в конце, а до конца он не дойдёт. Приведу так же пример из моего
примера в "Практике":</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000000">&nbsp;
</font><font color="#000099">Do</font></font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;&nbsp;
''с помощью InStr получаем местоположение искомого символа</font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;&nbsp;
''если оно равно нулю, покидаем цикл</font>
<br><font size="-1"><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;
ReturnNumber = InStr(1, Stroka, Symbol):</font><font color="#000099"> If</font><font color="#000000">
_</font></font>
<br><font size="-1"><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;
ReturnNumber = 0 </font><font color="#000099">Then Exit Do</font></font>
<br><font size="-1"><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;
</font><font color="#006600">''строке присваем все символы слева до искомого
символа и справа</font></font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;
Stroka = Left(Stroka, ReturnNumber - 1) + _</font>
<br><font color="#000000"><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;
Right(Stroka, Len(Stroka) - ReturnNumber)</font></font></font>
</p><p><font size="-1" face="Tahoma" color="#000099">&nbsp;
Loop</font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Здесь
невозможно воспользоваться ни </font><font color="#000099">Until</font><font color="#000000">,
ни </font><font color="#000099">While, </font><font color="#000000">и вот
почему: если ReturnNumber будет равно нулю, то, допустим, здесь</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Left(Stroka,
ReturnNumber - 1)</font>
</p><p><font size="-1" face="Tahoma" color="#000000">возникнет
ошибка, т.к. минимальную длину функция Left понимает только 0, а здесь
получается -1 (0 - 1)!!! Поэтому</font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Do
Until</font><font color="#000000"> ReturnNumber = 0</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">поставить
нельзя, ведь переменная </font><font color="#000099">Integer</font><font color="#000000">
"от рождения" равна нулю и цикл проигнорирует сам себя тут же. OK, но мы
можем прежде написать:</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">ReturnNumber
= 1</font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">ДА!
И цикл откроется, сделае всё и как надо, но когда искомые символы кончатся
и ReturnNumber снова будет равно нулю ПОСЛЕ проверки и поэтому опять возникает
ошибка! Тогда ставим перед </font><font color="#000099">Loop</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Until</font><font color="#000000">
ReturnNumber = 0</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">в конец.
И здесь опять та же самая беда - ReturnNumber будет равно нулю теперь ДО
проверки и ОПЯТЬ ошибка!!! Остаётся одно - воспользоваться в нужном месте
выходом из цикла </font><font color="#000099">Exit Do</font><font color="#000000">.
Где это нужное место? А там где функцмя только узнает, что искомых символов
больше нет, т.е. сразу после неё ставим условие:</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">If</font><font color="#000000">
ReturnNumber = 0 </font><font color="#000099">Then Exit Do</font></font>
</p><p><b><font size="-1" face="Tahoma" color="#000000">Конструкция&nbsp;<a name="For...Next"></a>For...Next.</font></b>
</p><p><font size="-1" face="Tahoma" color="#000000">Итак,
цикл For...Next это, наверное, самый простой и нужный цикл в программирований
на Visual Basic. Его применяют, когда число повторений известно заранее.
В отличии от цикла Do, в цикле For используется переменная, называемая
<i>переменной
цикла </i>или <i>счётчиком цикла</i>. Которая увеличивается или уменьшается
на заданую величину при каждом повторении цикла. Самый-самый простой пример,
который приводит везде, где приводится ;-) :</font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">For</font><font color="#000000">
x = 1 </font><font color="#000099">To</font><font color="#000000"> 3&nbsp;&nbsp;
</font><font color="#006600">''переменную x, равную 1, возводим до 3</font></font>
<br><font size="-1"><font color="#000000">&nbsp;&nbsp;&nbsp;
Beep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font><font color="#006600">''"бибикаем"
;-)</font></font>
<br><font size="-1"><font color="#000099">Next
</font><font color="#000000">x</font><font color="#000099">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font><font color="#006600">''идём в начало цикла</font></font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Visual
Basic выполняет цикл For...Next в следующей последовательности:</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">1.
Присваевает переменной х значение 1.</font>
<br><font size="-1" color="#000000">2.
Сравнивает присвоеное значение икса и то, которое надо присвоить (3). Если
х больше, либо равно трём прекращает своё&nbsp; выполнение, при условии,
что&nbsp; заданные "шаги" (Step) не отрицательны.</font>
<br><font size="-1" color="#000000">3.
Выполняет операторы в теле цикла.</font>
<br><font size="-1" color="#000000">4.
У величивает переменную x на один, т.к.&nbsp; шаги не заданы.</font>
<br><font size="-1" color="#000000">5.
Повторяет пункты со 2 по 4.</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Ещё
один пример (печатает на форме имена всех имеющихся шрифтов):</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">1.
Создаём форму.</font>
<br><font size="-1" color="#000000">2.
Открываем окно Code.</font>
<br><font size="-1" color="#000000">3.
Выбираем событие Click</font>
<br><font size="-1" color="#000000">4.
Вписываем:</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font><font color="#000000">
I </font><font color="#000099">As Integer&nbsp; </font><font color="#006600">''объявляем
меременную - счётчик</font></font>
<br><font size="-1" color="#006600">''запускаем
цикл столько раз, сколько имеется шрифтов</font>
<br><font size="-1" color="#006600">''(Screen.FontCount
возвращает кол-во всех шрифтов)</font>
<br><font size="-1"><font color="#000099">&nbsp;&nbsp;&nbsp;
For</font><font color="#000000"> I = 0 To Screen.FontCount</font></font>
<br><font size="-1" color="#006600">''печатает
каждое имя</font>
<br><font size="-1"><font color="#000099">&nbsp;&nbsp;&nbsp;
Print</font><font color="#000000"> Screen.Fonts(I)</font></font>
<br><font size="-1" color="#000099">Next</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Кстати
в конце цикла положено ставить имя переменной - счётчика. Вообще-то это
необязательно, но, во-первых, это, так сказать, правило хорошего тона,
а, во-вторых, так Вы не запутаетесь.</font>
</p><p><b><font size="-1" face="Tahoma" color="#000000">Кострукцин&nbsp;<a name="ForEach...Next"></a>For
Each...Next.</font></b>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Цикл
For Each...Next похож на цикл For...Next, но он повторяет группу операторов
для каждого элемента из <i>набора объектов</i> или из массива. О его пользе
судить я не могу, но могу только сказать, что мне он ещё <u>ни разу</u>
не пригодился. Хотя я ничего полезного-то и не делал ;-)).</font>
<br><font color="#000000"><font size="-1">Короче,
если Вам нужно изменить за раз все элементы массива или коллекции, Вы можете
использовать этот цикл. Например вот код, который:</font></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">1.
Создаёт массив.</font>
<br><font size="-1" color="#000000">2.
Увеличивает все элементы на один.</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Итак,
пишем в модуль:</font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Sub</font><font color="#000000">
Main()</font></font>
<br><font size="-1"><font color="#000099">Dim
</font><font color="#000000">a(6)</font><font color="#000099">
As Integer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font><font color="#006600">''объявляем
массив из шести ячеек</font></font>
<br><font size="-1" color="#006600">''объявляем
"универсальную" переменную, которую</font>
<br><font size="-1" color="#006600">''используют
как елемент массива или набора объектов</font>
<br><font size="-1"><font color="#000099">Dim</font><font color="#000000">
Element </font><font color="#000099">As Variant</font></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''запускаем
цикл столько раз, сколько всего ячеек в массиве а</font>
<br><font size="-1"><font color="#000099">For</font><font color="#000000">
x = 0 </font><font color="#000099">To UBound</font><font color="#000000">(a)</font></font>
<br><font size="-1"><font color="#000000">&nbsp;&nbsp;
a(x) = x&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font><font color="#006600">''присваеваем
каждой ячейке значение</font></font>
<br><font size="-1"><font color="#000000">&nbsp;&nbsp;</font><font color="#000099">
Debug.Print</font><font color="#000000"> a(x)&nbsp; </font><font color="#006600">''выводим
на экран, только что полученое значение</font></font>
<br><font color="#000099"><font size="-1">Next</font></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''запускаем
цикл For Each..Next, где будет изменяться Element в массиве а</font>
<br><font size="-1"><font color="#000099">For
Each </font><font color="#000000">Element </font><font color="#000099">In</font><font color="#000000">
a</font></font>
<br><font size="-1"><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;
Element = Element + 1 </font><font color="#006600">''увелчиваем каждый элемент
на один</font></font>
<br><font size="-1"><font color="#000000">&nbsp;&nbsp;

</font><font color="#000099">Debug.Print</font><font color="#000000">
Element&nbsp;&nbsp; 
</font><font color="#006600">''вывод на экран увеличенный
элемент</font></font>
<br><font size="-1"><font color="#000099">Next&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</font><font color="#006600">''в начало цикла</font></font>
<br><font color="#000099"><font size="-1">End
Sub</font></font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">В окне
Immediant появятся цифры от 0 до 6 - это бывшие значения массива а, и следом
цифры от 1 до 7, а это новые значения, увеличенные на один.</font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">И ещё
один пример, где все объекты на форме двигаются в право. Но, во-первых,
расскажу что такое Controls. Controls - это группа, где храняться все объекты
формы. Набор Controls создаётся автоматически при открытии новой формы
и пополняется при добавлении новых объектов.</font>
<br><font color="#000000"><font size="-1">Чтобы
сослаться на какой-нибудь объект, нужно написать Controls(Index). Внимание!
Важно знать, что Visual Basic хранит все объекты в обратном порядке их
создания. Например, если у Вас на форме был создан Text1, потом Label1,
а потом Combo1, то Combo1 будет иметь индекс 0, Label1 - 2, и Text1 будет
иметь 3. Неудобно, не правда ли? А теперь пример:</font></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">1.
Создайте форму.</font>
<br><font size="-1" color="#000000">2.
На ней создайте кучу объектов.</font>
<br><font size="-1" color="#000000">3.
Щёлкните два раза на форме и откройте окно Code.</font>
<br><font size="-1" color="#000000">4.
Выберите событие Click.</font>
<br><font size="-1" color="#000000">5.
Впишите следующее:</font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Private
Sub</font><font color="#000000"> Form_Click()</font></font>
<br><font size="-1"><font color="#000099">Dim</font><font color="#000000">
Element </font><font color="#000099">As Variant</font></font></font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">For
Each</font><font color="#000000"> Element </font><font color="#000099">In</font><font color="#000000">
Controls</font></font>
<br><font size="-1" color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;
Element.Left = Element.Left + 100</font>
<br><font size="-1"><font color="#000099">Next</font><font color="#000000">
Element</font></font>
<br><font size="-1" color="#000099">End
Sub</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Ну,
вот и поползли все объекты влево. Только будьте осторожны, если вы будете
кликать по объектам, а не по форме, они будут стоять как вкопанные.</font>
</p><p><font size="-1" face="Tahoma" color="#000000">ВСЁ!</font>

<br><br>

</p></td>
</tr>
</tbody>', 8, 14);
INSERT INTO VBDataSource.articles (ID, articleName, content, author, topic) VALUES (45, 'Массивы
', '<tbody><tr>
<td>
<br>

<h1 align="center">Массивы</h1>

<font face="Tahoma">

<br><font color="#000000"><font size="-1">Иногда
бывает так нужны десятка два переменных и, если бы не массив, прищлось
бы писать</font></font></font>
<p><font face="Tahoma"><font size="-1"><font color="#000099">Dim</font><font color="#000000">
A </font><font color="#000099">As Integer</font></font>
<br><font size="-1"><font color="#000099">Dim</font><font color="#000000">
B </font><font color="#000099">As Integer</font></font>
<br><font size="-1">.......</font>
<br><font size="-1">.......</font>
<br><font size="-1">.......</font>
<br><font size="-1"><font color="#000099">Dim</font><font color="#000000">
X </font><font color="#000099">As Integer</font></font>
<br><font size="-1"><font color="#000099">Dim</font><font color="#000000">
Y </font><font color="#000099">As Integer</font></font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Но
нет! Для этого есть массивы! Но для того, чтобы его использовать сначало
надо его объявить, например:</font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Dim</font><font color="#000000">
A(20) </font><font color="#000099">As Integer</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Это
равносильно двадцати переменным!!! Но по-моему так удобней :)? Т.е. этим
мы выделили двадцать ячеек памяти.</font>
</p><p><font size="-1" face="Tahoma" color="#000000">Массив
представляет собой набор значений, связанных с одним именем. Массивы бывают
одномерными (список значения), двумерными (таблица значений), но при необходимости
работы со сложными математическими моделями, например, трёхмерными фигурами,
Вы можете задать и большее количество измерений массива. Массивы могут
быть так же динамический, т.е. не содержать определённое количество ячеек.
Декларируются они так:</font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Dim</font><font color="#000000">
ABC () </font><font color="#000099">As ... </font><font color="#006600">''т.е.
в скобках ничего не указывается</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Чтобы
установить размерность массива нужно использовать ключевое слово </font><font color="#000099">ReDim</font><font color="#000000">,
которое перераспределяет массив, стирая старые ячейки.</font></font>
</p><p><font size="-1" face="Tahoma"><font color="#000000">Если
Вам нужно перераспределить массив, оставив старые ячейки надо использовать
ключевое слово </font><font color="#000099">Preserve</font><font color="#000000">.</font></font>
</p><p><font size="-1" face="Tahoma" color="#000000">Например,
у Вас есть восемь чисел и для каждого нужна переменная. Если они одинакового
типа, то можно создать массив и присвоить эти значения (<a name="zur"></a><a href="#Prim">см.
примечания</a>):</font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Dim</font><font color="#000000">
ABC (8) </font><font color="#000099">As Integer</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">ABC(0)
= 123</font>
<br><font size="-1">ABC(1)
= 5</font>
<br><font size="-1">ABC(2)
= 87</font>
<br><font size="-1">ABC(3)
= 4</font>
<br><font size="-1">ABC(4)
= 99</font>
<br><font size="-1">ABC(5)
= 43</font>
<br><font size="-1">ABC(6)
= 7</font>
<br><font size="-1">ABC(7)
= 21</font>
<br><font size="-1" color="#000000">ABC(8)
= 11</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Этот
массив графически можно представить так:</font>
<br>&nbsp;</font>
<table border="" cols="10" width="100%">
<tbody><tr>
<td><font face="Tahoma">Ячейка</font></td>

<td><font face="Tahoma">0</font></td>

<td><font face="Tahoma">1</font></td>

<td><font face="Tahoma">2</font></td>

<td><font face="Tahoma">3</font></td>

<td><font face="Tahoma">4</font></td>

<td><font face="Tahoma">5</font></td>

<td><font face="Tahoma">6</font></td>

<td><font face="Tahoma">7</font></td>

<td><font face="Tahoma">8</font></td>
</tr>

<tr>
<td><font face="Tahoma">Значение</font></td>

<td><font face="Tahoma">123</font></td>

<td><font face="Tahoma">5</font></td>

<td><font face="Tahoma">87</font></td>

<td><font face="Tahoma">4</font></td>

<td><font face="Tahoma">99</font></td>

<td><font face="Tahoma">43</font></td>

<td><font face="Tahoma">7</font></td>

<td><font face="Tahoma">21</font></td>

<td><font face="Tahoma">11</font></td>
</tr>
</tbody></table>

</p><p><font size="-1" face="Tahoma">Допустим, что Вы пишите программу,
которая создаёт палитры и она должна запросить количество цветов, которые
она должна смешать и какие (Вы только сильно не радуйтесь следующий пример
ничего мешать не будет, он только запросит цвета ;-)):</font>
</p><p><font face="Tahoma"><font size="-1"><font color="#000099">Sub</font>
Main()</font>
<br><font size="-1"><font color="#000099">Dim
</font>MyArray()
<font color="#000099">As
String</font><font color="#006600">''объявляем массив, содержащий цвета</font></font>
<br><font size="-1"><font color="#000099">Dim</font>
x <font color="#000099">As Integer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</font><font color="#006600">''объявляем переменную, содержащую кол-во
цветов</font></font>
<br><font size="-1"><font color="#000099">Dim</font>
y <font color="#000099">As Integer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</font><font color="#006600">''объявляем переменную-счётчик</font></font>
<br><font size="-1"><font color="#000099">Dim
</font>Msg
<font color="#000099">As
String&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font><font color="#006600">''объявляем
переменную, содержащую все названия цветов</font></font>
<br><font size="-1">x = InputBox("Введите число
цветов") <font color="#006600">''получаем количество цветов</font></font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''перераспределяем
в массиве столько ячеек, сколько цветов мы получили</font>
<br><font size="-1"><font color="#000099">ReDim</font>
MyArray(x)</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''запускаем
цикл, который должен повториться столько раз сколько всего</font>
<br><font size="-1" color="#006600">''цветов</font>
<br><font size="-1"><font color="#000099">For</font>
y = 1 To <font color="#000099">x</font></font>
<br><font size="-1" color="#006600">&nbsp;&nbsp;&nbsp;
''присваеваем каждой ячейке цвет</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; MyArray(y)
= InputBox("Ведите цвет номер " &amp; y)</font>
<br><font size="-1" color="#000099">Next</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#006600">''запускаем
цикл, который собирает все цвета в одну переменную</font>
<br><font size="-1"><font color="#000099">For
</font>y
= 1 <font color="#000099">To</font> x</font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; <font color="#006600">''теперь
мы вытаскиваем все значения</font></font>
<br><font size="-1">&nbsp;&nbsp;&nbsp; Msg =
Msg + MyArray(y) + Chr(13) + Chr(10)</font>
<br><font size="-1" color="#000099">Next</font></font>
</p><p><font size="-1" face="Tahoma">MsgBox Msg&nbsp;&nbsp;&nbsp; <font color="#006600">''выводим все цвета, которые ввели</font></font>
</p><p><font size="-1" face="Tahoma" color="#000099">End
Sub</font>
</p><p><font size="-1" face="Tahoma">Здесь вроде бы всё просто!
Теперь двумерный массив. Но не пугайтесь, здесь не менее просто, только
с непривычки можно чуть-чуть запутаться :-).</font>
</p><p><font size="-1" face="Tahoma">Декларируются они так:</font>
</p><p><font size="-1" face="Tahoma"><font color="#000099">Dim</font>
ABC(1, 8) <font color="#000099">As String</font></font>
</p><p><font face="Tahoma"><font size="-1" color="#000000">Это
получается этакая таблица: две ячейки на десять. Примерно так:</font>
<br>&nbsp;</font>
<table border="" cols="10" width="100%">
<tbody><tr>
<td></td>

<td><font face="Tahoma">0</font></td>

<td><font face="Tahoma">1</font></td>

<td><font face="Tahoma">2</font></td>

<td><font face="Tahoma">3</font></td>

<td><font face="Tahoma">4</font></td>

<td><font face="Tahoma">5</font></td>

<td><font face="Tahoma">6</font></td>

<td><font face="Tahoma">7</font></td>

<td><font face="Tahoma">8</font></td>
</tr>

<tr>
<td><font face="Tahoma">0</font></td>

<td><font face="Tahoma">красный</font></td>

<td><font face="Tahoma">оранжевый</font></td>

<td><font face="Tahoma">жёлтый</font></td>

<td><font face="Tahoma">зелёный</font></td>

<td><font face="Tahoma">голубой</font></td>

<td><font face="Tahoma">синий</font></td>

<td><font face="Tahoma">фиолетовый</font></td>

<td><font face="Tahoma">бирюзовый</font></td>

<td><font face="Tahoma">пурпурный</font></td>
</tr>

<tr>
<td><font face="Tahoma">1</font></td>

<td><font face="Tahoma">коричневый</font></td>

<td><font face="Tahoma">серый</font></td>

<td><font face="Tahoma">чёрный&nbsp;</font></td>

<td><font face="Tahoma">белый</font></td>

<td><font face="Tahoma">розовый</font></td>

<td><font face="Tahoma">лиловый</font></td>

<td><font face="Tahoma">вишнёвый</font></td>

<td><font face="Tahoma">прозрачный</font></td>

<td><font face="Tahoma">матовый</font></td>
</tr>
</tbody></table>
<font size="-1" face="Tahoma">И всё это присвоить таким образом:</font>
</p><p><font face="Tahoma"><font size="-1">ABC(0, 0) = "красный"</font>
<br><font size="-1">ABC(0, 1) = "оранжевый"</font>
<br><font size="-1">ABC(0, 2) = "жёлтый"</font></font>
</p><p><font size="-1" face="Tahoma">и т.д. Ну, очень напоминает
систему координат! А чтобы вызвать, например, лиловый нужно написать так:</font>
</p><p><font size="-1" face="Tahoma">Color = ABC(1, 5) <font color="#006600">''переменной
color присваеваем строку "лиловый"</font></font>
</p><p><font size="-1" face="Tahoma">Трёхмерную таблицу я начертить
не смогу, но думаю, что и там всё понятно. Объявляется он, например так:</font>
</p><p><font size="-1" face="Tahoma">Dim ABC (10, 4, 7)</font>
</p><p><font face="Tahoma"><font size="-1">Таким образом уже создётся
как бы геометрический прямоугольник длиной 10, шириной - 4 и высотой -
7. Всего внутри 440 ячеек ( 11 * 5 * 8).</font>
<br>
</font>
</p><hr width="100%"><font face="Tahoma"><a name="Prim"></a><b><font color="#FF0000"><font size="-1">Примечание:
Вы должны помнить, что объявляя массив с, например, тремя ячейками, в скобках
Вы должны писать 2,</font></font></b>
</font>
<p><font size="-1" face="Tahoma"><font color="#000099">Dim</font><font color="#000000">
ABC(2) </font><font color="#000099">As Variant</font></font>
</p><p><b><font size="-1" face="Tahoma" color="#FF0000">т.к.
идекс ячеек начинается с нуля: 0, 1, 2 - в сумме получается три. Если в
скобках окажется цифра три, то ячеек будет четыре: 0, 1, 2, 3. Если Вам
кажется это неудобным, то строкой (в самом верху формы или модуля):</font></b>
</p><p><font size="-1" face="Tahoma" color="#000099">Option
Base 1</font>
</p><p><b><font face="Tahoma"><font size="-1" color="#FF0000">Вы
как бы сдвините массив вверх на один, и нижней границей станет не 0, а
1. Также есть другой способ:</font></font></b><font face="Tahoma"><br><br>
<font size="-1"><font color="#000099">Dim</font> ABC(1 To 2)</font>
<br><br><font size="-1"><b>Результат одинаков!</b></font><br><b><font size="-1"><a href="#zur">назад</a></font></b>
<br>
</font>

<br><br>

</p></td>
</tr>
</tbody>', 8, 14);