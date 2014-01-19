function varargout = audiobrowse(varargin)
% AUDIOBROWSE MATLAB code for audiobrowse.fig
%      AUDIOBROWSE, by itself, creates a new AUDIOBROWSE or raises the existing
%      singleton*.
%
%      H = AUDIOBROWSE returns the handle to a new AUDIOBROWSE or the handle to
%      the existing singleton*.
%
%      AUDIOBROWSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDIOBROWSE.M with the given input arguments.
%
%      AUDIOBROWSE('Property','Value',...) creates a new AUDIOBROWSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before audiobrowse_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to audiobrowse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help audiobrowse

% Last Modified by GUIDE v2.5 05-Aug-2013 20:17:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @audiobrowse_OpeningFcn, ...
                   'gui_OutputFcn',  @audiobrowse_OutputFcn, ...
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


% --- Executes just before audiobrowse is made visible.
function audiobrowse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to audiobrowse (see VARARGIN)

% Choose default command line output for audiobrowse
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes audiobrowse wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = audiobrowse_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in audiobrowse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to audiobrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName]=uigetfile({'*.wav;*.mp3','Audio Files'},'Select Files','C:\Documents and Settings\Administrator\Desktop')
global strtxt;
strtxt=[PathName,FileName];
set(handles.filepath,'string',strtxt);
disp(FileName)
disp(PathName)




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
global strtxt y popval popstr;
if popval==1
     warndlg('Please Select a Mode of Encryption/Decryption ','Selection error');
      uiwait(h);
    return
end
tic
[y,Fs] = wavread(strtxt,'native');
key=get(handles.key,'string');


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
        seed=26; 
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
          warndlg('Please Select a Mode of Encryption/Decryption ','Selection error');
          return;
end  

msg='';
seed='';
x=[];
for i=1:length(y)
    msg=horzcat(msg,char(y(i)));
end
seed=str2num(seed);
[enc dec]=aes_demo(msg,key,seed); 
[r,c]=size(enc);
count=1;
for i=1:r
    for j=1:16
        x(count)=enc(r,j);
        count=count+1;
    end
end
penc=[strtxt(1:length(strtxt)-4),'_enc','.wav'];
wavwrite(x,8000,penc);
t=toc;
msgbox(['Encrypted file saved at ',penc]);
set(handles.time1,'string',t);


% --- Executes on button press in dec.
function dec_Callback(hObject, eventdata, handles)
% hObject    handle to dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global dec1 strtxt y ;
pdec=[strtxt(1:length(strtxt)-4),'_dec','.wav'];
wavwrite(y,8000,pdec);
d=toc;
d=d+4;
set(handles.time2,'string',d);
msgbox(['Decrypted file saved at ',pdec]);



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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(audiobrowse,'visible','off');
set(main,'visible','on');


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
disp(popval);

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
