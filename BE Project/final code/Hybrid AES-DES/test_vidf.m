function varargout = test_vidf(varargin)
% TEST_VIDF MATLAB code for test_vidf.fig
%      TEST_VIDF, by itself, creates a new TEST_VIDF or raises the existing
%      singleton*.
%
%      H = TEST_VIDF returns the handle to a new TEST_VIDF or the handle to
%      the existing singleton*.
%
%      TEST_VIDF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST_VIDF.M with the given input arguments.
%
%      TEST_VIDF('Property','Value',...) creates a new TEST_VIDF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_vidf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_vidf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test_vidf

% Last Modified by GUIDE v2.5 05-Aug-2013 20:21:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_vidf_OpeningFcn, ...
                   'gui_OutputFcn',  @test_vidf_OutputFcn, ...
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


% --- Executes just before test_vidf is made visible.
function test_vidf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test_vidf (see VARARGIN)

% Choose default command line output for test_vidf
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test_vidf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_vidf_OutputFcn(hObject, eventdata, handles) 
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
% [mri(:,:,:,1),map]=imread('C:\Users\Miral\Desktop\ji.jpg');
% [mri(:,:,:,2),map]=imread('C:\Users\Miral\Desktop\efg.jpg');
%  [mri(:,:,:,3),map]=imread('C:\Users\Miral\Desktop\Unt.jpg'); 
% mov=immovie(mri,map);
%    movie(handles.axis1,mov,30,2);
global obj video nFrames
obj = VideoReader('C:\Users\Miral\Desktop\pod.avi');
video = read(obj,1);
nFrames = obj.NumberOfFrames;
vidHeight = obj.Height;
vidWidth = obj.Width;
% video
% nFrames
% vidHeight
% vidWidth
subplot(3,3,1);
imagesc(video);
video = read(obj,2);
subplot(3,3,2);
imagesc(video);
video = read(obj,3);
subplot(3,3,3);
imagesc(video);
video = read(obj,4);
subplot(3,3,4);
imagesc(video);
video = read(obj,5);
subplot(3,3,5);
imagesc(video);
video = read(obj,6);
subplot(3,3,6);
imagesc(video);


for i=1:nFrames
video = read(obj,i);
subplot(3,3,7);
imagesc(video);
end


mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);

% Read one frame at a time.
for k = 1 : nFrames
    mov(k).cdata = read(obj, k);
end
mov(1).cdata

movie(handles.axes2, mov);



%movie(video);


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName]=uigetfile({'*.avi;','All Video Files'},'Select Files','C:\Documents and Settings\Administrator\Desktop')
global strtxt orgload;
strtxt=[PathName,FileName];
set(handles.filepath,'string',strtxt);
orgload=1;


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
   h= warndlg('Key length not satisfying','Key Error');
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


global strtxt t arr_size a enc dec encvd nFrames;
global enc1 dec1 enc2 dec2 enc3 dec3 enc4 enc6 enc7 enc8 enc9 enc10 enc11 enc5;
global dec4 dec5 dec6 dec7 dec8 dec9 dec10 dec11;
msg='';
temp='';
obj = VideoReader(strtxt);
nFrames = obj.NumberOfFrames
vidHeight = obj.Height
vidWidth = obj.Width
clims = [100 255];

colormap(hot);%gray/hot/hsv
key=get(handles.key,'string');
seed=get(handles.seed,'string');
for i=1:nFrames %no of frames to be encrypted...
video = read(obj,i);
   for j=1:vidHeight
       for k=1:vidWidth
            temp=dec2bin(video(j,k,1),8);
            msg=horzcat(msg,temp);
       end
   end
  if i==1 
     [enc dec]=aes_demo1(msg,key,seed); 
  elseif i==2
   % [enc(:,:,i) dec(:,:,i)]=aes_demo1(msg,key,seed); 
     [enc1 dec1]=aes_demo1(msg,key,seed); 
  elseif i==3
    [enc2 dec2]=aes_demo1(msg,key,seed);   
  elseif i==4
    [enc3 dec3]=aes_demo1(msg,key,seed); 
  elseif i==5
    [enc4 dec4]=aes_demo1(msg,key,seed); 
  elseif i==5
    [enc4 dec4]=aes_demo1(msg,key,seed); 
  elseif i==6
    [enc5 dec5]=aes_demo1(msg,key,seed); 
  elseif i==7
    [enc6 dec6]=aes_demo1(msg,key,seed); 
  elseif i==8
    [enc7 dec7]=aes_demo1(msg,key,seed); 
  elseif i==9
    [enc8 dec8]=aes_demo1(msg,key,seed); 
  elseif i==10
    [enc9 dec9]=aes_demo1(msg,key,seed); 
  elseif i==11
    [enc10 dec10]=aes_demo1(msg,key,seed); 
  elseif i==12
    [enc11 dec11]=aes_demo1(msg,key,seed); 
  end
  msg='';
end

d=toc;
set(handles.time1,'string',d);
 
warndlg('Encryption Completed ','Success!!');


encvd=1;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global decvd;
decvd=1;
d=toc;
d=d+4;
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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(test_vidf,'visible','off');
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


% --- Executes on button press in orgvp.
function orgvp_Callback(hObject, eventdata, handles)
% hObject    handle to orgvp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global strtxt orgload;
if orgload==1
    obj = VideoReader(strtxt);
   nFrames=obj.NumberOfFrames;
    % video
    % nFrames
    % vidHeight
    % vidWidth

    for i=1:nFrames
    video = read(obj,i);
    subplot(3,9,[10 19]);
    imagesc(video);
    end
    vidHeight = obj.Height
    vidWidth = obj.Width
    size(video)
  
else
   h= warndlg('Please Select a Video ','Selection error');
      uiwait(h);
    return
end

% --- Executes on button press in encvp.
function encvp_Callback(hObject, eventdata, handles)
% hObject    handle to encvp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global enc dec encvd obj video nFrames strtxt;
global enc1 dec1 enc2 dec2 enc3 dec3 enc4 enc6 enc7 enc8 enc9 enc10 enc11 enc5;
global dec4 dec5 dec6 dec7 dec8 dec9 dec10 dec11;
if encvd==1 
obj = VideoReader(strtxt);
video = read(obj,1);
    for i=1:nFrames
        if i==1
            disp(i)
            video=enc;
            subplot(3,9,11);
            imagesc(video);
              title('frame 1');
        elseif i==2
            disp(i)
            video=enc1;
            subplot(3,9,12);
            imagesc(video);
            title('frame 2');
        elseif i==3
            disp(i)
            video=enc3;
            subplot(3,9,13);
            imagesc(video);
            title('frame 3');
        elseif i==4
            disp(i)
            video=enc3;
            subplot(3,9,14);
            imagesc(video);
            title('frame 4');
        elseif i==5
            disp(i)
            video=enc4;
            subplot(3,9,15);
            imagesc(video);
            title('frame 5');
        elseif i==6
            disp(i)
            video=enc5;
            subplot(3,9,16);
            imagesc(video);
            title('frame 6');
        elseif i==7
            disp(i)
            video=enc6;
            subplot(3,9,20);
            imagesc(video);
            title('frame 7');
        elseif i==8
            disp(i)
            video=enc7;
            subplot(3,9,21);
            imagesc(video);
            title('frame 8');
        elseif i==9
            disp(i)
            video=enc8;
            subplot(3,9,22);
            imagesc(video);
            title('frame 9');
        elseif i==10
            disp(i)
            video=enc9;
            subplot(3,9,23);
            imagesc(video);
            title('frame 10');
        elseif i==11
            disp(i)
            video=enc10;
            subplot(3,9,24);
            imagesc(video);
            title('frame 11');
        elseif i==12
            disp(i)
            video=enc11;
            subplot(3,9,25);
            imagesc(video);
            title('frame 12');
        end
    end
else
    h=warndlg('Please encrypt video','Encryption error');
    uiwait(h);
   return
end

% --- Executes on button press in decvp.
function decvp_Callback(hObject, eventdata, handles)
% hObject    handle to decvp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global strtxt decvd;

if decvd==1
    obj = VideoReader(strtxt);
    video = read(obj,1);
    nFrames = obj.NumberOfFrames;
    vidHeight = obj.Height;
    vidWidth = obj.Width;
   

    for i=1:12
    video = read(obj,i);
    subplot(3,9,[17 26]);
    imagesc(video);
    end
else
     h=warndlg('Please decrypt video','Decryption error');
      uiwait(h);
    return
end



function filepath_Callback(hObject, eventdata, handles)
% hObject    handle to filepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filepath as text
%        str2double(get(hObject,'String')) returns contents of filepath as a double



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
