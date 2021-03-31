function varargout = two_way_login(varargin)
% TWO_WAY_LOGIN MATLAB code for two_way_login.fig
%      TWO_WAY_LOGIN, by itself, creates a new TWO_WAY_LOGIN or raises the existing
%      singleton*.
%
%      H = TWO_WAY_LOGIN returns the handle to a new TWO_WAY_LOGIN or the handle to
%      the existing singleton*.
%
%      TWO_WAY_LOGIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_WAY_LOGIN.M with the given input arguments.
%
%      TWO_WAY_LOGIN('Property','Value',...) creates a new TWO_WAY_LOGIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_way_login_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_way_login_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_way_login

% Last Modified by GUIDE v2.5 30-Mar-2021 20:45:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_way_login_OpeningFcn, ...
                   'gui_OutputFcn',  @two_way_login_OutputFcn, ...
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
global password;
global full_flag;


% --- Executes just before two_way_login is made visible.
function two_way_login_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_way_login (see VARARGIN)

% Choose default command line output for two_way_login
handles.output = hObject;
handles.panel_biometric.Visible = 'off';  % Or 'off'
% handles.panel_biometric.Enable = 'off';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_way_login wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_way_login_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.jpg';'*.bmp'},'File Selector');
 handles.myImage = strcat(pathname, filename);
 axes(handles.axes1);
 imshow(handles.myImage)



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
radioButton1State = get(handles.radiobutton1, 'Value');
radioButton2State = get(handles.radiobutton2, 'Value');
if radioButton1State 
%   bio_type = 'finger_extract.csv';
  load dataset/model_finger.mat c
  secretKey = 'kuncirahasiafinger';
  col_poss = 6;
end
if radioButton2State 
%   bio_type = 'face_extract.csv';
  load dataset/model_face.mat c
  secretKey = 'kuncirahasiaface';
  col_poss = 5;
end
% data_fitur_name = sprintf('dataset/%s',bio_type);
% data_fitur = csvread(data_fitur_name,1);
img = getimage(handles.axes1);
img = rgb2gray(img);
glcm = graycomatrix(img,'Offset',[2 0]);
stats = graycoprops(glcm)
contrast = stats.Contrast;
homogeneity = stats.Homogeneity;
correlation = stats.Correlation;
energy = stats.Energy;

fitur=[contrast homogeneity correlation energy];
[class,~]=predict(c,fitur);

if class==1
        user_id='edward404';
    elseif class==2
        user_id='nickey203';
    elseif class==3
        user_id='jonson256';
    elseif class==4
        user_id='charly128';
    elseif class==5
        user_id='dalton512';
end


opts = detectImportOptions('database/user_database2.csv','TextType','string');
T = readtable('database/user_database2.csv',opts);

algorithm = "MD5";

aes = AES(secretKey, algorithm);
pass_enkrip = aes.encrypt(user_id);
n_data = size(T,1);
flag=0;

global full_flag;

msg = sprintf('%s %d %d %d',user_id, class, col_poss, full_flag);
msgbox(msg,'Output Params');

for i=1:n_data
    user_temp = T{i,col_poss};
    if (user_temp == pass_enkrip && full_flag==1)
        the_user = T{i,3};
        flag=1;
        break;
    end
end

if flag==1
    msg = sprintf('Selamat datang %s. Anda berhasil login',the_user);
    msgbox(msg,'Output Params');
else
    msg = sprintf('Maaf username atau password anda tidak terdaftar');
    msgbox(msg,'Output Params');
end


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global password
password = passcode();


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
username = get(handles.edit1,'String');

radioButton3State = get(handles.radiobutton3, 'Value');
radioButton4State = get(handles.radiobutton4, 'Value');
if radioButton3State 
  user_role = 'user';
end
if radioButton4State 
  user_role = 'admin';
end

global password
pass = password;

opts = detectImportOptions('database/user_database2.csv','TextType','string');
T = readtable('database/user_database2.csv',opts);

secretKey = "kuncirahasia";
algorithm = "MD5";

% msg = sprintf('Maaf username atau password anda tidak terdaftar');
% msgbox(pass,'Output Params');

aes = AES(secretKey, algorithm);
pass_enkrip = aes.encrypt(pass);
n_data = size(T,1);
flag=0;

for i=1:n_data
    role = T{i,9};
    if role==user_role
        user_temp = T{i,2};
        pass_temp=T{i,4};
        if (user_temp==username & pass_temp == pass_enkrip)
            the_user = T{i,3};
            flag=1;
            break;
        end
    end
end

if flag==1
    
    handles.panel_biometric.Visible = 'on';
    global full_flag
    full_flag = 1;
    
else
    msg = sprintf('Maaf username atau password anda tidak terdaftar');
    msgbox(msg,'Output Params');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
select_authentication
closereq()


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
two_way_login
closereq()


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq()
