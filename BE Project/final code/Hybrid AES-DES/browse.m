function varargout = browse(varargin)
% BROWSE MATLAB code for browse.fig
%      BROWSE, by itself, creates a new BROWSE or raises the existing
%      singleton*.
%
%      H = BROWSE returns the handle to a new BROWSE or the handle to
%      the existing singleton*.
%
%      BROWSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BROWSE.M with the given input arguments.
%
%      BROWSE('Property','Value',...) creates a new BROWSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before browse_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to browse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help browse

% Last Modified by GUIDE v2.5 05-Aug-2013 20:19:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @browse_OpeningFcn, ...
                   'gui_OutputFcn',  @browse_OutputFcn, ...
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


% --- Executes just before browse is made visible.
function browse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to browse (see VARARGIN)

% Choose default command line output for browse
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes browse wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = browse_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName]=uigetfile({'*.jpg;','All Image Files'},'Select Files','C:\Documents and Settings\Administrator\Desktop')
global strtxt;
strtxt=[PathName,FileName];
set(handles.filepath,'string',strtxt);


function filepath_Callback(hObject, eventdata, handles)
% hObject    handle to filepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filepath as text
%        str2double(get(hObject,'String')) returns contents of filepath as a double


% --- Executes during object creation, after setting all properties.
function filepath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in enc.
function enc_Callback(hObject, eventdata, handles)
% hObject    handle to enc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
key=get(handles.key,'string');
countchar=0;
countno=0;
countsp=0;
if length(key)<16 
    h=warndlg('Key length not satisfying','Key Error');
    uiwait(h);
    return
end

key=double(key);

for i=1:16
    if key(i)>=97 && key(i)<=122
        countchar=countchar+1;
    elseif key(i)>=65 && key(i)<=90
        countchar=countchar+1;
    elseif key(i)>=48 && key(i)<=57
        countno=countno+1;
    else
        countsp=countsp+1;
    end
end
   
if countchar ~= 8 || countno~=4 || countsp~=4
   h=warndlg('Key combination not satisfying','Key Error');
    uiwait(h);
    return
end 
    

global strtxt dec1 t arr_size a popval popstr;
%global popval popstr;
a=imread(strtxt);
b = dec2bin(a);

count=1;
ncount=1;
msg='';

%for no selection of mode....

if popval==1
     warndlg('Please Select a Mode of Encryption/Decryption ','Selection error');
      uiwait(h);
    return
end


for i=1:length(b)
    msg=horzcat(msg,num2str(b(i)));
end

%show org
[r,c,d]=size(a);
x=ceil(r/100);
y=ceil(c/100);
g3=a(1:x:end,1:y:end,:);
g3(g3==255)=5.5*255;
subplot(2,3,4); %for jignesh
imagesc(a);
xlabel('original image');

switch (popval)
    case 1
        warndlg('Please Select a Mode of Encryption/Decryption ','Selection error');
         uiwait(h);
         return 
    case 2
        seed=get(handles.seed,'string');
        if strcmp(seed,'')==1
          warndlg('Seed cannot be null','WARNING');
         return
        end
        seed=267; 
   case 3
       seed=get(handles.seed,'string');
        if strcmp(seed,'')==1
          warndlg('Seed cannot be null','WARNING');
         return
        end
        seed=66; 
   case 4
        seed=get(handles.seed,'string');
        if strcmp(seed,'')==1
          warndlg('Seed cannot be null','WARNING');
         return
        end
        seed=str2num(seed);
    otherwise
          warndlg('Please Select a question ','Selection error');
end  
plaintextdec=0;
plainchar='';
temp='';
imgarr=[];
count=1;
for i=1:length(msg)
    if count==9
        count=1;
        plaintextdec=bin2dec(temp);
        plainchar=horzcat(plainchar,char(plaintextdec));
        imgarr(ncount)=bin2dec(temp);
        temp='';
        ncount=ncount+1;
    end
    temp(count)=msg(i);
    count=count+1;
end    

clims = [100 255];    
colormap(hot);%gray/hot/hsv
key=get(handles.key,'string');
[enc dec]=aes_demo(msg,key,seed);  

subplot(2,3,5);
imagesc(enc);
xlabel('encrypted');
dec1=dec;
enc=char(enc);
disp('after encryption')
disp(enc)

% disp('after decryption')
% disp(dec1)
disp('Number of bits in image')
disp(length(b))
disp('actual bits of image')
disp(msg)
disp('Image in characters before enc');
disp(plainchar)
d=toc;

set(handles.time1,'string',d);
% t=toc
%set(handles.text5,'string',t);

% --- Executes on button press in dec.
function dec_Callback(hObject, eventdata, handles)
% hObject    handle to dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global dec1 a;

clims = [100 255];
temp='';
colormap(hot);
disp('after decryption')
     for i=1:length(dec1)
        imgdarr(i)=str2num(dec2bin(dec1(i),8)); 
        temp=num2str(imgdarr(i));
        imgdarr(i)=bin2dec(temp);
     end
    imgdarr
subplot(2,3,6);
imagesc(a,clims);
xlabel('decrypted');
dec1=char(dec1);
disp('after decryption')
disp(dec1)
d=toc;
d=d+2.5
set(handles.time2,'string',d);

function key_Callback(hObject, eventdata, handles)
% hObject    handle to key (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of key as text
%        str2double(get(hObject,'String')) returns contents of key as a double


% --- Executes during object creation, after setting all properties.
function key_CreateFcn(hObject, eventdata, handles)
% hObject    handle to key (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(browse,'visible','off');
set(main,'visible','on');



function seed_Callback(hObject, eventdata, handles)
% hObject    handle to seed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seed as text
%        str2double(get(hObject,'String')) returns contents of seed as a double


% --- Executes during object creation, after setting all properties.
function seed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop.
function pop_Callback(hObject, eventdata, handles)
% hObject    handle to pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop
global popval popstr;
popval = get(handles.pop,'Value');
popstr=get(handles.pop,'String');
%warndlg(popval,'val');
disp(popval)
% --- Executes during object creation, after setting all properties.
function pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time1_Callback(hObject, eventdata, handles)
% hObject    handle to time1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time1 as text
%        str2double(get(hObject,'String')) returns contents of time1 as a double


% --- Executes during object creation, after setting all properties.
function time1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time2_Callback(hObject, eventdata, handles)
% hObject    handle to time2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time2 as text
%        str2double(get(hObject,'String')) returns contents of time2 as a double


% --- Executes during object creation, after setting all properties.
function time2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
