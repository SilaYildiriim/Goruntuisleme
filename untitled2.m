function varargout = untitled2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled2_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function untitled2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = untitled2_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function Resimyukle_Callback(hObject, eventdata, handles)
global image
global filename
global pathname

[filename, pathname] = uigetfile('*','Resim dosyasını seçiniz:'); 
fullPathName =strcat( pathname, filename);
image=imread(fullPathName);

axes(handles.axes2);
imshow(image);
height = size(image,1);
width = size(image,2);

%Burada groupbox içerisindeki oushbuttonların enabled larının aktifleşmesi
%sağlanmaktadır. GUI ekrNı ilk yüklenirken bu elementler enable özelliği
%Off olarak gelmekte ve resim seçildiği an işlemin yapılması için enabl On
%hale getirilir.
set(handles.EsiklemeButton, 'enable', 'on');
set(handles.GriButton, 'enable', 'on');
set(handles.HistogramEsitlemeButton, 'enable', 'on');
set(handles.btnGauss, 'enable', 'on');
set(handles.btnSobel, 'enable', 'on');
set(handles.btnLaplace, 'enable', 'on');

%Burada histogram ve kontrast için kullanılacak olan axes ler
%gizlenilmektedir. Aynı zmaanda resmin adı, yolu ve genişlik-yükseklik
%bilgileri ekranda static text üzerine yazdırılmaktadır. 
set(handles.axes7, 'visible','off');
set(handles.axes8, 'visible','off'); 
set(handles.editresimadi, 'String', filename);
set(handles.editresimyolu, 'String', pathname);
set(handles.txt_Genislik, 'String', width);
set(handles.txt_Yukseklik, 'String', height);

% Seçilen Resmin adı ve yolunun dosyaya kaydedilmesi sağlanılıyor. 
fid = fopen('myfile.txt','a');
fprintf(fid,'Resim Adı : %s \n',filename);
fprintf(fid,'Resmin Yolu : %s \n',pathname);
fprintf(fid,'********************************************************************** \n');
fclose(fid);


% --- Executes on button press in btnGauss (BULANIKLA�TIRMA).
function btnGauss_Callback(hObject, eventdata, handles)
global image
 
    axes(handles.axes3);
    imshow(image);
    axes(handles.axes4);
    imshow(GaussFonksiyon(image, 1));


% --- Executes on button press in btnSobel (KENAR BULMA).
function btnSobel_Callback(hObject, eventdata, handles)
global image

    axes(handles.axes3);
    imshow(image);
    axes(handles.axes4);
    imshow(SobelFonksiyon(image, 1));

% --- Executes on button press in btnLaplace (KESK�NLE�T�RME).
function btnLaplace_Callback(hObject, eventdata, handles)
global image


    axes(handles.axes3);
    imshow(image);
    axes(handles.axes4);
    imshow(LaplaceFonksiyon(image, 1));


% --- Executes on button press in EsiklemeButton.
function EsiklemeButton_Callback(hObject, eventdata, handles)
global image

axes(handles.axes3);
imshow(image);
axes(handles.axes4);
imshow(convert2binary(image));


% --- Executes on button press in GriButton.
function GriButton_Callback(hObject, eventdata, handles)
global image   

axes(handles.axes3);
imshow(image);

axes(handles.axes4);
imshow(GrayCevir(image));



% --- Executes on button press in HistogramEsitlemeButton.
function HistogramEsitlemeButton_Callback(hObject, eventdata, handles)
global image

% Burada visible ayarını yapma sebebim şudur; histogram grafiğini
% çizdirirken orjinal resim ve grafiği ve sonrasında da oluşan reism ve
% grafiğini belirtmek için 2 axes daha eklenildi. Bu axesler diğer
% panellerdeki pushbuttonlarda görünmemekle birlikte sadece histogram
% eşitleme de ihtiyaçtan doğan sebeple bu şekilde eklenilmesi
% düşünülmüştür.
set(handles.axes7, 'visible','on');
set(handles.axes8, 'visible','on');

%Burada orjinal resim ve histogram grafiği gösterilmektedir. 
axes(handles.axes3);
imshow(image);
axes(handles.axes4);
imhist(image);

%Burada Histogram eşitleme sonucu oluşan resim ve grafiği gösterilmiştir.
axes(handles.axes7);
imshow(uint8(HistogramEsitleme(image)));
axes(handles.axes8);
imhist(HistogramEsitleme(image));


% --- Executes on button press in PictureSave.
function PictureSave_Callback(hObject, eventdata, handles)

[FileName, PathName] = uiputfile({'*.jpg';'*.bmp';'*.png'},...
        'G�r�nt� Dosyas� Kaydetme');
Name = fullfile(PathName,FileName);
F=getframe(handles.axes4);
W=frame2im(F);
imwrite(W, Name, 'tif');


% --------------------------------------------------------------------
function islemlerMenu_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function noktaBazliIslemler_Callback(hObject, eventdata, handles)
set(handles.noktaBazliGroup, 'visible', 'on');

% --------------------------------------------------------------------
function filtreIslemleri_Callback(hObject, eventdata, handles)
set(handles.filtreGroup, 'visible', 'on');

% --------------------------------------------------------------------
function morfolojikIslemler_Callback(hObject, eventdata, handles)
set(handles.morfolojikGroup, 'visible', 'on');


% --- Executes on selection change in popup_Morfolojik.
function popup_Morfolojik_Callback(hObject, eventdata, handles)
global image
morfolojikIslemler = get(handles.popup_Morfolojik, 'Value');
switch(morfolojikIslemler)
    case 2
        axes(handles.axes3);
        imshow(image);
        axes(handles.axes4);
        imshow(Erosion(image));
    case 3
        axes(handles.axes3);
        imshow(image);
        axes(handles.axes4);
        imshow(Genisleme(image));
  
    otherwise
end


% --- Executes during object creation, after setting all properties.
function popup_Morfolojik_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% Burada ekran ilk açıldığı hale gelmektedir.
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');
cla(handles.axes4,'reset');
cla(handles.axes7,'reset');
cla(handles.axes8,'reset');
set(handles.axes7,'visible', 'off');
set(handles.axes8,'visible', 'off');
set(handles.noktaBazliGroup,'visible', 'off');
set(handles.filtreGroup,'visible', 'off');
set(handles.morfolojikGroup,'visible', 'off');
set(handles.sikistirmaGroup,'visible', 'off');
set(handles.editresimadi,'String', ' '); 
set(handles.editresimyolu,'String', ' ');
set(handles.txt_Genislik,'String', ' ');
set(handles.editBoyut,'String', ' ');
set(handles.txt_Yukseklik,'String', ' ');



function editBoyut_Callback(hObject, eventdata, handles)
% hObject    handle to editBoyut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBoyut as text
%        str2double(get(hObject,'String')) returns contents of editBoyut as a double


% --- Executes during object creation, after setting all properties.
function editBoyut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBoyut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_gauss_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gauss as text
%        str2double(get(hObject,'String')) returns contents of edit_gauss as a double


% --- Executes during object creation, after setting all properties.
function edit_gauss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editresimadi_Callback(hObject, eventdata, handles)
% hObject    handle to editresimadi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editresimadi as text
%        str2double(get(hObject,'String')) returns contents of editresimadi as a double


% --- Executes during object creation, after setting all properties.
function editresimadi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editresimadi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editresimyolu_Callback(hObject, eventdata, handles)
% hObject    handle to editresimyolu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editresimyolu as text
%        str2double(get(hObject,'String')) returns contents of editresimyolu as a double


% --- Executes during object creation, after setting all properties.
function editresimyolu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editresimyolu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_Yukseklik_Callback(hObject, eventdata, handles)
% hObject    handle to txt_Yukseklik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_Yukseklik as text
%        str2double(get(hObject,'String')) returns contents of txt_Yukseklik as a double


% --- Executes during object creation, after setting all properties.
function txt_Yukseklik_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_Yukseklik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_Genislik_Callback(hObject, eventdata, handles)
% hObject    handle to txt_Genislik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data s(see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_Genislik as text
%        str2double(get(hObject,'String')) returns contents of txt_Genislik as a double


% --- Executes during object creation, after setting all properties.
function txt_Genislik_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_Genislik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over popup_Morfolojik.
function popup_Morfolojik_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to popup_Morfolojik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on popup_Morfolojik and none of its controls.
function popup_Morfolojik_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popup_Morfolojik (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
