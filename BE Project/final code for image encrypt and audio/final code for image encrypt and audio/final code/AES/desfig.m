function varargout = desfig(varargin)
global t;
tic
% DESFIG M-file for desfig.fig
%      DESFIG, by itself, creates a new DESFIG or raises the existing
%      singleton*.
%
%      H = DESFIG returns the handle to a new DESFIG or the handle to
%      the existing singleton*.
%
%      DESFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DESFIG.M with the given input arguments.
%
%      DESFIG('Property','Value',...) creates a new DESFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before desfig_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to desfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help desfig

% Last Modified by GUIDE v2.5 19-Mar-2012 17:15:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @desfig_OpeningFcn, ...
                   'gui_OutputFcn',  @desfig_OutputFcn, ...
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


% --- Executes just before desfig is made visible.
function desfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to desfig (see VARARGIN)

% Choose default command line output for desfig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes desfig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = desfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input as text
%        str2double(get(hObject,'String')) returns contents of input as a double


% --- Executes during object creation, after setting all properties.
function input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputdes=get(handles.input,'string');
keydes=get(handles.key,'string');
encdes=latdes(inputdes,keydes,0);
encdes=char(encdes)';
set(handles.enout,'string',encdes');
%if inputdes==''
 %   msgbox('input missing','Error msg','error');
%end
%if keydes==''
  %  msgbox('input missing','Error msg','error');
%end  
%if length(keydes)>8
%    msgbox('incorrct key');
%end
t=toc
set(handles.time1,'string',t);
% --- Executes on button press in deout.
function deout_Callback(hObject, eventdata, handles)
% hObject    handle to deout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic

inputdes=get(handles.enout,'string');
keydes=get(handles.key,'string');
decdes=latdesdec(inputdes,keydes,0);
decdes=char(decdes)';
set(handles.text4,'string',decdes');

d=toc;

set(handles.time2,'string',d);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input,'String','');
set(handles.time1,'String','');
set(handles.enout,'String','');
set(handles.key,'String','');
set(handles.time2,'String','');
set(handles.text4,'String','');



set(front,'visible','on');
set(desfig,'visible','off');


% --- Executes during object creation, after setting all properties.
