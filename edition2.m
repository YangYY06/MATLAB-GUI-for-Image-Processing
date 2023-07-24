function varargout = edition2(varargin)
% EDITION2 MATLAB code for edition2.fig
%      EDITION2, by itself, creates a new EDITION2 or raises the existing
%      singleton*.
%
%      H = EDITION2 returns the handle to a new EDITION2 or the handle to
%      the existing singleton*.
%
%      EDITION2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDITION2.M with the given input arguments.
%
%      EDITION2('Property','Value',...) creates a new EDITION2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edition2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edition2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help edition2

% Last Modified by GUIDE v2.5 04-Jun-2022 18:13:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edition2_OpeningFcn, ...
                   'gui_OutputFcn',  @edition2_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before edition2 is made visible.
function edition2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edition2 (see VARARGIN)

% Choose default command line output for edition2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes edition2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = edition2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=uigetfile({'*.jpg';'*.bmp';'*.jpeg';'*.png'}, 'Load Image from');
handles.ori_img=imread(image);
handles.img=imread(image);
axes(handles.g1); 
cla; 
imshow(handles.ori_img);
axes(handles.g2); 
cla; 
imshow(handles.img);
axes(handles.g3); 
cla; 
guidata(hObject,handles);

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file,path]= uiputfile({'*.jpg';'*.bmp';'*.jpeg';'*.png'},'Save Image as');
save=[path file];
imwrite(handles.img,save);

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% axes(handles.g2); 
% cla; 
% handles.img=handles.ori_img;
% guidata(hObject,handles);
handles.img=handles.ori_img;
axes(handles.g2); 
cla; 
imshow(handles.ori_img);
axes(handles.g3);
cla;
guidata(hObject,handles);
% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --- Executes on button press in ave.
function ave_Callback(hObject, eventdata, handles)
% hObject    handle to ave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
size1=str2double(get(handles.kernel_size1,'String'));
axes(handles.g2);
cla; 
imshow(handles.img);
h=fspecial('average',size1);
handles.img=imfilter(handles.img,h,'replicate');
axes(handles.g3);
cla; 
imshow(handles.img);
guidata(hObject,handles);

% --- Executes on button press in med.
function med_Callback(hObject, eventdata, handles)
% hObject    handle to med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
size2=str2double(get(handles.kernel_size2,'String'));
axes(handles.g2);
cla; 
imshow(handles.img);
mysize=size(handles.img);
kernel=[size2 size2];
if numel(mysize)>2
    r=medfilt2(handles.img(:,:,1),kernel);
    g=medfilt2(handles.img(:,:,2),kernel);
    b=medfilt2(handles.img(:,:,3),kernel); 
    handles.img=cat(3,r,g,b);
else
    handles.img=medfilt2(handles.img,kernel);
end
axes(handles.g3);
cla; 
imshow(handles.img);
guidata(hObject,handles);

% --- Executes on button press in gau.
function gau_Callback(hObject, eventdata, handles)
% hObject    handle to gau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
size3=str2double(get(handles.kernel_size3,'String'));
sigma=str2double(get(handles.sigma,'String'));
axes(handles.g2);
cla; 
imshow(handles.img);
kernel=[size3 size3];
h=fspecial('gaussian',kernel,sigma);
handles.img=imfilter(handles.img,h,'replicate');
axes(handles.g3);
cla; 
imshow(handles.img);
guidata(hObject,handles);

function kernel_size1_Callback(hObject, eventdata, handles)
% hObject    handle to kernel_size1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kernel_size1 as text
%        str2double(get(hObject,'String')) returns contents of kernel_size1 as a double



% --- Executes during object creation, after setting all properties.
function kernel_size1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kernel_size1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kernel_size2_Callback(hObject, eventdata, handles)
% hObject    handle to kernel_size2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kernel_size2 as text
%        str2double(get(hObject,'String')) returns contents of kernel_size2 as a double


% --- Executes during object creation, after setting all properties.
function kernel_size2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kernel_size2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kernel_size3_Callback(hObject, eventdata, handles)
% hObject    handle to kernel_size3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kernel_size3 as text
%        str2double(get(hObject,'String')) returns contents of kernel_size3 as a double


% --- Executes during object creation, after setting all properties.
function kernel_size3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kernel_size3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sigma_Callback(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigma as text
%        str2double(get(hObject,'String')) returns contents of sigma as a double


% --- Executes during object creation, after setting all properties.
function sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in n1.
function n1_Callback(hObject, eventdata, handles)
% hObject    handle to n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.g2);
cla; 
imshow(handles.img);
handles.img = imnoise(handles.img,'gaussian');
axes(handles.g3); 
cla; 
imshow(handles.img);
guidata(hObject,handles);


% --- Executes on button press in n2.
function n2_Callback(hObject, eventdata, handles)
% hObject    handle to n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.g2);
cla; 
imshow(handles.img);
handles.img = imnoise(handles.img,'poisson');
axes(handles.g3); 
cla; 
imshow(handles.img);
guidata(hObject,handles);


% --- Executes on button press in n3.
function n3_Callback(hObject, eventdata, handles)
% hObject    handle to n3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.g2);
cla; 
imshow(handles.img);
handles.img = imnoise(handles.img,'salt & pepper');
axes(handles.g3); 
cla; 
imshow(handles.img);
guidata(hObject,handles);


% --- Executes on button press in gray.
function gray_Callback(hObject, eventdata, handles)
% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.g2);
cla; 
imshow(handles.img);
mysize=size(handles.img);
if numel(mysize)>2
handles.img = rgb2gray(handles.img);
end
axes(handles.g3); 
cla; 
imshow(handles.img);
guidata(hObject,handles);


% --- Executes on button press in lap.
function lap_Callback(hObject, eventdata, handles)
% hObject    handle to lap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.g2);
cla; 
imshow(handles.img);
h=fspecial('laplacian',0);
handles.img=imfilter(handles.img,h,'replicate');
axes(handles.g3); 
cla; 
imshow(handles.img);
guidata(hObject,handles);


% --- Executes on button press in roberts.
function roberts_Callback(hObject, eventdata, handles)
% hObject    handle to roberts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.g2);
cla; 
imshow(handles.img);
mysize=size(handles.img);
if numel(mysize)>2
    handles.img=rgb2gray(handles.img);
end
handles.img=edge(handles.img,'roberts');
handles.img=double(handles.img);
axes(handles.g3); 
cla; 
imshow(handles.img);
guidata(hObject,handles);


% --- Executes on button press in sobel.
function sobel_Callback(hObject, eventdata, handles)
% hObject    handle to sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.g2);
cla; 
imshow(handles.img);
mysize=size(handles.img);
if numel(mysize)>2
    handles.img=rgb2gray(handles.img);
end
handles.img=edge(handles.img,'sobel');
handles.img=double(handles.img);
axes(handles.g3); 
cla; 
imshow(handles.img);
guidata(hObject,handles);


% --- Executes on button press in LoG.
function LoG_Callback(hObject, eventdata, handles)
% hObject    handle to LoG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.g2);
cla; 
imshow(handles.img);
mysize=size(handles.img);
if numel(mysize)>2
    handles.img=rgb2gray(handles.img);
end
handles.img=edge(handles.img,'log');
handles.img=double(handles.img);
axes(handles.g3); 
cla; 
imshow(handles.img);
guidata(hObject,handles);



function up_Callback(hObject, eventdata, handles)
% hObject    handle to up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of up as text
%        str2double(get(hObject,'String')) returns contents of up as a double


% --- Executes during object creation, after setting all properties.
function up_CreateFcn(hObject, eventdata, handles)
% hObject    handle to up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lo_Callback(hObject, eventdata, handles)
% hObject    handle to lo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lo as text
%        str2double(get(hObject,'String')) returns contents of lo as a double


% --- Executes during object creation, after setting all properties.
function lo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function si_Callback(hObject, eventdata, handles)
% hObject    handle to si (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of si as text
%        str2double(get(hObject,'String')) returns contents of si as a double


% --- Executes during object creation, after setting all properties.
function si_CreateFcn(hObject, eventdata, handles)
% hObject    handle to si (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in canny.
function canny_Callback(hObject, eventdata, handles)
% hObject    handle to canny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.g2);
cla; 
imshow(handles.img);
mysize=size(handles.img);
if numel(mysize)>2
    handles.img=rgb2gray(handles.img);
end
up=str2double(get(handles.up,'String'));
low=str2double(get(handles.lo,'String'));
sigma=str2double(get(handles.si,'String'));
thres=[low up];
handles.img=edge(handles.img,'canny',thres,sigma);
handles.img=double(handles.img);
axes(handles.g3); 
cla; 
imshow(handles.img);
guidata(hObject,handles);
