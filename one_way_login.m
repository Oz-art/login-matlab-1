function varargout = one_way_login(varargin)
% ONE_WAY_LOGIN MATLAB code for one_way_login.fig
%      ONE_WAY_LOGIN, by itself, creates a new ONE_WAY_LOGIN or raises the existing
%      singleton*.
%
%      H = ONE_WAY_LOGIN returns the handle to a new ONE_WAY_LOGIN or the handle to
%      the existing singleton*.
%
%      ONE_WAY_LOGIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ONE_WAY_LOGIN.M with the given input arguments.
%
%      ONE_WAY_LOGIN('Property','Value',...) creates a new ONE_WAY_LOGIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before one_way_login_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to one_way_login_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help one_way_login

% Last Modified by GUIDE v2.5 30-Mar-2021 18:25:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @one_way_login_OpeningFcn, ...
                   'gui_OutputFcn',  @one_way_login_OutputFcn, ...
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

global password


% --- Executes just before one_way_login is made visible.
function one_way_login_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to one_way_login (see VARARGIN)

% Choose default command line output for one_way_login
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes one_way_login wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = one_way_login_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function userOneLogin_Callback(hObject, eventdata, handles)
% hObject    handle to userOneLogin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userOneLogin as text
%        str2double(get(hObject,'String')) returns contents of userOneLogin as a double


% --- Executes during object creation, after setting all properties.
function userOneLogin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userOneLogin (see GCBO)
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

username = get(handles.edit3,'String');

% radioButton1State = get(handles.radiobutton1, 'Value');
% radioButton2State = get(handles.radiobutton2, 'Value');
% if radioButton1State 
%   user_role = 'user';
% end
% if radioButton2State 
%   user_role = 'admin';
% end

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

[user,sys] = memory;
tic
akurasi=0;
for i=1:n_data
        user_temp = T{i,2};
        pass_temp=T{i,4};
        if (user_temp==username & pass_temp == pass_enkrip)
            the_user = T{i,3};
            flag=1;
            akurasi=1
            break;
        end
end

waktu=toc
if flag==1
    msg = sprintf('Selamat datang %s. Anda berhasil login',the_user);
    msgbox(msg,'Output Params');
else
    msg = sprintf('Maaf username atau password anda tidak terdaftar');
    msgbox(msg,'Output Params');
    
end
[user2,sys2] = memory;
memory_used=abs(user2.MemAvailableAllArrays-user.MemAvailableAllArrays);

size_ones = uint8([1 waktu*10000])

compx=ones(size_ones);

[complex,~] = calc_lz_complexity(compx,'primitive',0);
complexs = (complex)*(waktu*10000);
random_t=randi(9,2);
random_t=reshape(random_t,[1,4]);




% db_vector = [the_user string(token) string(akurasi) string(waktu) string(memory_used) string(complex)]

opts2 = detectImportOptions('database/output_one_way.csv','TextType','string');
T2 = readtable('database/output_one_way.csv',opts2);
% db_vector=table(db_vector);


out.user = the_user;
out.token = string(sprintf("%d%d",flag,random_t));
out.akurasi=string(akurasi);
out.waktu_pemrosesan=waktu;
out.memori=memory_used;
out.kompleksitas=string(complexs)

db_vector = struct2table(out);

T3 = [T2; db_vector];
writetable(T3,'database/output_one_way.csv');

            
            




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
select_authentication
closereq()


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user_role
closereq()



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
