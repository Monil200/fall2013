function varargout = frametest(varargin)
% FRAMETEST MATLAB code for frametest.fig
%      FRAMETEST, by itself, creates a new FRAMETEST or raises the existing
%      singleton*.
%
%      H = FRAMETEST returns the handle to a new FRAMETEST or the handle to
%      the existing singleton*.
%
%      FRAMETEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRAMETEST.M with the given input arguments.
%
%      FRAMETEST('Property','Value',...) creates a new FRAMETEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before frametest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to frametest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help frametest

% Last Modified by GUIDE v2.5 23-Jul-2013 20:49:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @frametest_OpeningFcn, ...
                   'gui_OutputFcn',  @frametest_OutputFcn, ...
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


% --- Executes just before frametest is made visible.
function frametest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to frametest (see VARARGIN)

% Choose default command line output for frametest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes frametest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = frametest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global obj video nFrames
obj = VideoReader('C:\Users\Miral\Desktop\pod.avi');
video = read(obj,2);
nFrames = obj.NumberOfFrames
vidHeight = obj.Height
vidWidth = obj.Width


subplot(3,9,[10 19]);
imagesc(video);
video = read(obj,3);
subplot(3,9,11);
imagesc(video);
video = read(obj,5);
subplot(3,9,12);
imagesc(video);
video = read(obj,4);
subplot(3,9,12);
imagesc(video);
video = read(obj,5);
subplot(3,9,13);
imagesc(video);
video = read(obj,6);
subplot(3,9,14);
imagesc(video);
video = read(obj,7);
subplot(3,9,15);
imagesc(video);
video = read(obj,8);
subplot(3,9,16);
imagesc(video);
video = read(obj,9);
subplot(3,9,20);
imagesc(video);
video = read(obj,10);
subplot(3,9,21);
imagesc(video);
video = read(obj,11);
subplot(3,9,22);
imagesc(video);
video = read(obj,12);
subplot(3,9,23);
imagesc(video);
video = read(obj,6);
subplot(3,9,24);
imagesc(video);
video = read(obj,4);
subplot(3,9,25);
imagesc(video);
video = read(obj,1);
subplot(3,9,[17 26]);
imagesc(video);