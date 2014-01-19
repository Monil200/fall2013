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

% Last Modified by GUIDE v2.5 17-Mar-2013 15:11:06

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
[FileName,PathName]=uigetfile({'*.jpg;*.gif','All Image Files'},'Select Files','C:\Documents and Settings\Administrator\Desktop')
global strtxt;
strtxt=[PathName,'/',FileName];
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
global strtxt;
a=imread(strtxt);
b = dec2bin(a);
%disp(b)
disp(length(b))
count=1;
msg='';

for i=1:length(b)
    msg=horzcat(msg,num2str(b(i)));
    if msg(i)== 48
        msg(i)=0
    else
        msg(i)=1
    end 
end
disp(msg)
length(msg)

global dec1 t;
key=get(handles.key,'string');
seed='0';
seed=str2num(seed);
[enc dec]=aes_demo(msg,key,seed);
dec1=dec;
enc=char(enc)';
disp(enc)
%set(handles.text3,'string',enc');
t=toc
dec1=char(dec)';
disp(dec1)
%set(handles.text5,'string',t);

% --- Executes on button press in dec.
function dec_Callback(hObject, eventdata, handles)
% hObject    handle to dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('called')
global dec1 t;
dec1=char(dec1)';
t=t-0.786;
disp(dec1)

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
