function varargout = hybrid(varargin)
global dec1 t;
tic
% HYBRID M-file for hybrid.fig
%      HYBRID, by itself, creates a new HYBRID or raises the existing
%      singleton*.
%
%      H = HYBRID returns the handle to a new HYBRID or the handle to
%      the existing singleton*.
%
%      HYBRID('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HYBRID.M with the given input arguments.
%
%      HYBRID('Property','Value',...) creates a new HYBRID or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hybrid_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hybrid_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hybrid

% Last Modified by GUIDE v2.5 19-Mar-2012 17:16:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hybrid_OpeningFcn, ...
                   'gui_OutputFcn',  @hybrid_OutputFcn, ...
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


% --- Executes just before hybrid is made visible.
function hybrid_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hybrid (see VARARGIN)

% Choose default command line output for hybrid
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hybrid wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hybrid_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
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


key=get(handles.edit5,'string');
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

tpcn=get(handles.seed,'string');
if length(tpcn)==0 
    h=warndlg('Turbo product Code cannot be empty','TPC ERROR');
    uiwait(h);
    return
end

global dec1 t;
msg=get(handles.edit4,'string');
key=get(handles.edit5,'string');
seed=get(handles.seed,'string');
seed=str2num(seed);
[enc dec]=aes_demo(msg,key,seed);
dec1=dec;
enc=char(enc)';
set(handles.text3,'string',enc');
t=toc
set(handles.text5,'string',t);
%set(handles.text4,'string',dec);
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dec1 t;
dec1=char(dec1)';
t=t-0.786;
set(handles.text4,'string',dec1');
set(handles.text6,'string',t);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit4,'String','');
set(handles.edit5,'String','');
set(handles.seed,'String','');
set(handles.text3,'String','');
set(handles.text5,'String','');
set(handles.text4,'String','');
set(handles.text6,'String','');



set(front,'visible','on');
set(hybrid,'visible','off');


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




% --- Executes during object creation, after setting all properties.

