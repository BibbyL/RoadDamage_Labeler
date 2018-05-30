function varargout = RDLabel(varargin)
% RDLABEL MATLAB code for RDLabel.fig
%      RDLABEL, by itself, creates a new RDLABEL or raises the existing
%      singleton*.
%
%      H = RDLABEL returns the handle to a new RDLABEL or the handle to
%      the existing singleton*.
%
%      RDLABEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RDLABEL.M with the given input arguments.
%
%      RDLABEL('Property','Value',...) creates a new RDLABEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RDLabel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RDLabel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RDLabel

% Last Modified by GUIDE v2.5 24-May-2018 19:52:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RDLabel_OpeningFcn, ...
                   'gui_OutputFcn',  @RDLabel_OutputFcn, ...
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


% --- Executes just before RDLabel is made visible.
function RDLabel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RDLabel (see VARARGIN)

% Choose default command line output for RDLabel

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RDLabel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RDLabel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global Loding_Path;
global Frame_step;
global I; % Original image
global Y; % Answer image
global I_tmp;
global Y_tmp;
global Release_Show;
global SE1;
global SE2;
global Sigma;
global SHOW_CHECK; SHOW_CHECK = 0;
global H;
global speed;
global isEase; isEase =0;
global isCUT; isCUT=0;
global h_CUT;
global w_CUT;
w_CUT  = str2double(get(handles.editWindow_W,'String'));
h_CUT  = str2double(get(handles.editWindow_H,'String'));
SE1 = str2double(get(handles.editSE1,'String'));
SE2 = str2double(get(handles.editSE2,'String'));
Sigma = str2double(get(handles.editSigma,'String'));
H = str2double(get(handles.editH, 'string'));
Release_Show = 0;
Frame_step = str2double(get(handles.editFrameStep,'String'));
speed = str2double(get(handles.editSpeed, 'string'));
addpath('./Source/');
axes(handles.axes1);
imshow(zeros(960,1280));
axes(handles.axes2);
imshow(zeros(960,1280));

function editLoadingPath_Callback(hObject, eventdata, handles)
% hObject    handle to editLoadingPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLoadingPath as text
%        str2double(get(hObject,'String')) returns contents of editLoadingPath as a double


% --- Executes during object creation, after setting all properties.
function editLoadingPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLoadingPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editSavingPath_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editSavingPath_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFrameStep_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editFrameStep_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonLoad.
function pushbuttonLoad_Callback(hObject, eventdata, handles)

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
global H;
global I; % Original image
global Y; % Answer image
global I_tmp; % for Next Step Original image
global Y_tmp; % for tmp answer
global x;
global y;
global x_tmp;
global y_tmp;
global speed;
global isCUT;
global w_CUT; 
global h_CUT; 
global isEase;
global I_Cut_original;

H = str2double(get(handles.editH, 'string'));
speed = str2double(get(handles.editSpeed, 'string'));
currPt = get(gca, 'CurrentPoint');
x = currPt(1,1);
y = currPt(1,2); %fprintf('\nx=%f,y=%f',x,y);
set(handles.editMouseStatus, 'string', ['Mouse pressed @ X: ', num2str(round(x)), ', Y: ', num2str(round(y))]);
if x>0 && y>0
    x_tmp = x;
    y_tmp = y;
else
    x = x_tmp;
    y = y_tmp;
end
x = round(x);
y = round(y); 

if isCUT  
    if isEase
        I_tmp = Recover_Image(I_Cut_original, I, Y, y, x, H, H, 1);
        Y_tmp = Recover_Image(I_Cut_original, I, Y, y, x , H, H, 2);
        axes(handles.axes1);
        imshow(I_tmp);
        pushbuttonShow_Callback(hObject, eventdata, handles);
    else
        I_tmp = Mark_Rectangle(I, 0, round(y), round(x), H, H, 2);
        Y_tmp = Mark_Rectangle(Y, 255, round(y), round(x), H, H);
        axes(handles.axes1);
        imshow(I_tmp);
        pushbuttonShow_Callback(hObject, eventdata, handles);
    end
else
    I_cut = label_CUT(I,x,y,h_CUT,w_CUT);
    axes(handles.axes1);
    imshow(I_cut);
end
% 
% axes(handles.axes1);
% imshow(I_tmp./255);

% --- Executes on button press in pushbuttonCUT.
function pushbuttonCUT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCUT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function pushbuttonSavingImage_Callback(hObject, eventdata, handles)
global I_heat;
global I_blur;
global Saving_Path;
global SavingName;
global I_Cut_original;
I_blur = I_blur./255;
if ~exist([Saving_Path '\Results\Heatmap'], 'dir')
    mkdir([Saving_Path '\Results\Heatmap']);
end
if ~exist([Saving_Path '\Results\Image'], 'dir')
    mkdir([Saving_Path '\Results\Image']);
end
if ~exist([Saving_Path '\Results\Mat_File'], 'dir')
    mkdir([Saving_Path '\Results\Mat_File']);
end
heat_path = 'Results\Heatmap\';
I_path    = 'Results\Image\';
Blur_path = 'Results\Mat_File\';
H_info    = sprintf('%s%s%s_heatmap.jpg', Saving_Path, heat_path, SavingName(1:end-4));
Blur_info = sprintf('%s%s%s_blur.mat', Saving_Path, Blur_path, SavingName(1:end-4));
I_info    = sprintf('%s%s%s.jpg', Saving_Path, I_path, SavingName(1:end-4));
imwrite(I_heat, H_info);
imwrite(I_Cut_original, I_info);
save(Blur_info, 'I_blur');

function pushbuttonShow_Callback(hObject, eventdata, handles)

global I_dilate;
global I_blur;
global I_heat;
global SE1;
global SE2;
global Sigma;
global Y_tmp;

se = strel('line',SE1, SE2);
I_dilate = imdilate(Y_tmp, se);
I_blur = imgaussfilt(I_dilate, Sigma);
I_heat = convertToHeapMap(I_blur./255, colormap);
axes(handles.axes2);
imshow(I_heat);


function editH_Callback(hObject, eventdata, handles)
% hObject    handle to editH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editH as text
%        str2double(get(hObject,'String')) returns contents of editH as a double


% --- Executes during object creation, after setting all properties.
function editH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
global I; % Original image
global Y; % Answer image
global I_tmp; % for Next Step Original image
global Y_tmp; % for tmp answer
global x;
global y;
global speed;
global SavingName;
global H;
global Sigma;
global I_heat;
global I_dilate;            
global I_blur;
global SE1;
global SE2;
global isEase;
global I_Cut_original;

switch eventdata.Key
    case 'rightarrow'
        x = x + speed;
    case 'leftarrow'
        x = x - speed;
    case 'uparrow'
        y = y - speed;
    case 'downarrow'
        y = y + speed;
     case 'd'
        x = x + speed;
    case 'a'
        x = x - speed;
    case 'w'
        y = y - speed;
    case 's'
        y = y + speed;    
    case 'q'
       speed = speed-1;
       if speed<1
            speed = 1;
        end
    case 'e'
       speed = speed+1;
       if speed<1
         speed = 1;
       end
    case 'space'
        I = I_tmp;
        Y = Y_tmp;
        if isEase
           axes(handles.axes1);
            imshow(I);
        end
     case 'r'
        H = H+1;
    case 't'
        H = H-1;
    case 'shift'
        pushbuttonCut_Callback(hObject, eventdata, handles);
    case 'control'
        pushbuttonSavingImage_Callback(hObject, eventdata, handles);
        set(handles.editMouseStatus, 'String', ['Save [' SavingName '] Successful'])
    case '1'
        H = 10;
    case '2'
        H = 20;
    case '3'
        H = 30;
    case '4'
        H = 40;    
    case 'capslock'    
        H = H/2; 
        if H ~= fix(H)
            H = floor(a);
        end
        if H<1.9
            H = 1;
        end
    case '5'
        if isEase == 0
            isEase = 1;
            set(handles.text3,'String', ['Ease mode ON']);
        else
            isEase = 0;
            set(handles.text3,'String', ['Ease mode OFF']);
        end
end
set(handles.editH, 'String', num2str(H));

if isEase
    I_tmp = Recover_Image(I_Cut_original, I, Y, y, x, H, H, 1);
    Y_tmp = Recover_Image(I_Cut_original, I, Y, y, x , H, H, 2);
    axes(handles.axes1);
    imshow(I_tmp);
    pushbuttonShow_Callback(hObject, eventdata, handles);
else

    set(handles.editSpeed, 'String', num2str(speed));
    I_tmp = Mark_Rectangle(I, 0, round(y), round(x), H, H, 2);
    Y_tmp = Mark_Rectangle(Y, 255, round(y), round(x), H, H);
    axes(handles.axes1);
    imshow(I_tmp);

    se = strel('line',SE1,SE2);
    I_dilate = imdilate(Y_tmp, se);
    I_blur = imgaussfilt(I_dilate, Sigma);
    I_heat = convertToHeapMap(I_blur./255, colormap);
    axes(handles.axes2);
    imshow(I_heat);

end


function editSpeed_Callback(hObject, eventdata, handles)
% hObject    handle to editSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function editSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key release with focus on figure1 and none of its controls.
function figure1_KeyReleaseFcn(hObject, eventdata, handles)

function editSE1_Callback(hObject, eventdata, handles)
global SE1;
SE1 = str2double(get(handles.editSE1,'String'));

% --- Executes during object creation, after setting all properties.
function editSE1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSE1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSE2_Callback(hObject, eventdata, handles)
global SE2;
SE2 = str2double(get(handles.editSE2,'String'));

% --- Executes during object creation, after setting all properties.
function editSE2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSE2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSigma_Callback(hObject, eventdata, handles)
global Sigma;
Sigma = str2double(get(handles.editSigma, 'string'));

% --- Executes during object creation, after setting all properties.
function editSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonNext.
function pushbuttonNext_Callback(hObject, eventdata, handles)
global I;
global Video;
global Frame_num;
global Frame_step;
global Y;
global Y_tmp;
global isCUT; isCUT=0;
global SavingName;
global filename;
Frame_num  = str2double(get(handles.textFrameNum,'String'));
Frame_step = str2double(get(handles.editFrameStep,'String'));
Frame_num = Frame_num + Frame_step;
set(handles.textFrameNum,'String', num2str(Frame_num));
SavingName = sprintf('%s-Frame%04d.jpg', filename(1:end-4), Frame_num);
set(handles.editSavingName, 'String', SavingName);
I = read(Video, Frame_num);
axes(handles.axes1);
imshow(I);
[h,w,~] = size(I);
Y = zeros(h,w);
Y_tmp = Y;
axes(handles.axes2);
imshow(Y);


% --- Executes on button press in pushbuttonPrevious.
function pushbuttonPrevious_Callback(hObject, eventdata, handles)
global I;
global Video;
global Frame_num;
global Frame_step;
global Y;
global Y_tmp;
global isCUT; isCUT=0;
global SavingName;
global filename;
Frame_num  = str2double(get(handles.textFrameNum,'String'));
Frame_step = str2double(get(handles.editFrameStep,'String'));
Frame_num = Frame_num - Frame_step;
if Frame_num<1
    Frame_num = 1;
end
SavingName = sprintf('%s-Frame%04d.jpg', filename(1:end-4), Frame_num);
set(handles.editSavingName, 'String', SavingName);
set(handles.textFrameNum,'String', num2str(Frame_num));
I = read(Video, Frame_num);
axes(handles.axes1);
imshow(I);
[h,w,~] = size(I);
Y = zeros(h,w);
Y_tmp = Y;
axes(handles.axes2);
imshow(Y);

% --- Executes on button press in pushbuttonBrowse1.
function pushbuttonBrowse1_Callback(hObject, eventdata, handles)
global filename; 
[filename, pathname] = uigetfile('*.MP4', 'Pick an video-file');
    if isequal(filename,0) || isequal(pathname,0)
      warndlg('Video is not selected');
    else
        disp(filename);
        disp(pathname);
    end

global Video;
global Frame_num;
global Y;
global I;
global Saving_Path;
global SavingName;
SavingName = sprintf('%s-Frame%04d.jpg', filename(1:end-4), Frame_num);
set(handles.editSavingName, 'String', SavingName);
Saving_Path = pathname;
set(handles.text3,'String', ['Saving Path:' Saving_Path]);
Frame_num = str2double(get(handles.textFrameNum,'String'));
Video = VideoReader([pathname filename]);
I = read(Video, Frame_num);
axes(handles.axes1);
imshow(I);
[h,w,~] = size(I);
Y = zeros(h,w);
axes(handles.axes2);
imshow(Y);

% --- Executes on button press in pushbuttonBrowse2.
function pushbuttonBrowse2_Callback(hObject, eventdata, handles)




function editWindow_H_Callback(hObject, eventdata, handles)
global h_CUT;
h_CUT  = str2double(get(handles.editWindow_H,'String'));

% --- Executes during object creation, after setting all properties.
function editWindow_H_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWindow_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editWindow_W_Callback(hObject, eventdata, handles)
global w_CUT;
w_CUT  = str2double(get(handles.editWindow_W,'String'));


% --- Executes during object creation, after setting all properties.
function editWindow_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWindow_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonCut.
function pushbuttonCut_Callback(hObject, eventdata, handles)

global I; % Original image
global Y; % Answer image
global x;
global y;
global isCUT; isCUT = 1;
global w_CUT; 
global h_CUT; 
global I_Cut_original;
[~, I] = label_CUT(I,x,y,h_CUT,w_CUT);
% I = I(y:y+w_CUT-1,x:x+h_CUT-1,:);
I_Cut_original = I;
[h,w,~] = size(I);
Y = zeros(h,w);
axes(handles.axes1);
imshow(I);
axes(handles.axes2);
imshow(Y);



function editSavingName_Callback(hObject, eventdata, handles)
global SavingName;
SavingName = str2double(get(handle.editSavingName, 'String'));

% --- Executes during object creation, after setting all properties.
function editSavingName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSavingName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebuttonEaser.
function togglebuttonEaser_Callback(hObject, eventdata, handles)
global isEase;
isEase = get(hObject,'Value');

% --- Executes on button press in togglebuttonShowMat.
function togglebuttonShowMat_Callback(hObject, eventdata, handles)
global I; % Original image
global Y; % Answer image
global I_dilate;
global I_blur;
global SE1;
global SE2;
global Sigma;
global Y_tmp;

State_Show = get(hObject,'Value');

if State_Show
    se = strel('line',SE1, SE2);
    I_dilate = imdilate(Y_tmp, se);
    I_blur = imgaussfilt(I_dilate, Sigma);
    axes(handles.axes1);
    imshow(I_blur);
else
    axes(handles.axes1);
    imshow(I);
end

% Hint: get(hObject,'Value') returns toggle state of togglebuttonShowMat
