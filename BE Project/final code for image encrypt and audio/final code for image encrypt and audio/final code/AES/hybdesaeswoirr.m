function varargout = hybdesaeswoirr(varargin)
% HYBDESAESWOIRR M-file for hybdesaeswoirr.fig
%      HYBDESAESWOIRR, by itself, creates a new HYBDESAESWOIRR or raises the existing
%      singleton*.
%
%      H = HYBDESAESWOIRR returns the handle to a new HYBDESAESWOIRR or the handle to
%      the existing singleton*.
%
%      HYBDESAESWOIRR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HYBDESAESWOIRR.M with the given input arguments.
%
%      HYBDESAESWOIRR('Property','Value',...) creates a new HYBDESAESWOIRR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hybdesaeswoirr_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hybdesaeswoirr_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hybdesaeswoirr

% Last Modified by GUIDE v2.5 14-Oct-2013 11:42:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hybdesaeswoirr_OpeningFcn, ...
                   'gui_OutputFcn',  @hybdesaeswoirr_OutputFcn, ...
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


% --- Executes just before hybdesaeswoirr is made visible.
function hybdesaeswoirr_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hybdesaeswoirr (see VARARGIN)

% Choose default command line output for hybdesaeswoirr
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hybdesaeswoirr wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hybdesaeswoirr_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


key=get(handles.edit2,'string');
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

tpcn=get(handles.tpcn,'string');
if length(tpcn)==0
    h=warndlg('Turbo product Code cannot be empty','TPC ERROR');
    uiwait(h);
    return
end


% --- Executes on button press in pushbutton2.
global dec1 t;
msg=get(handles.edit1,'string');
key=get(handles.edit2,'string');
seed='0';
seed=str2num(seed);
[enc dec]=aes_demo(msg,key,seed);
dec1=dec;
enc=char(enc)';
set(handles.text3,'string',enc');
t=toc
set(handles.text5,'string',t);












function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
global dec1 t;
dec1=char(dec1)';
t=t-0.786;
set(handles.text4,'string',dec1');
set(handles.text6,'string',t);




function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
set(handles.edit1,'String','');
set(handles.edit2,'String','');
set(handles.text3,'String','');
set(handles.text5,'String','');
set(handles.text4,'String','');
set(handles.text6,'String','');
set(front,'visible','on');
set(hybdesaeswoirr,'visible','off');




function tpcn_Callback(hObject, eventdata, handles)
% hObject    handle to tpcn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tpcn as text
%        str2double(get(hObject,'String')) returns contents of tpcn as a double


% --- Executes during object creation, after setting all properties.
function tpcn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tpcn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
