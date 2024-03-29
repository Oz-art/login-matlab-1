function varargout = select_authentication(varargin)
%SELECT_AUTHENTICATION MATLAB code file for select_authentication.fig
%      SELECT_AUTHENTICATION, by itself, creates a new SELECT_AUTHENTICATION or raises the existing
%      singleton*.
%
%      H = SELECT_AUTHENTICATION returns the handle to a new SELECT_AUTHENTICATION or the handle to
%      the existing singleton*.
%
%      SELECT_AUTHENTICATION('Property','Value',...) creates a new SELECT_AUTHENTICATION using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to select_authentication_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SELECT_AUTHENTICATION('CALLBACK') and SELECT_AUTHENTICATION('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SELECT_AUTHENTICATION.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help select_authentication

% Last Modified by GUIDE v2.5 30-Mar-2021 15:59:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @select_authentication_OpeningFcn, ...
                   'gui_OutputFcn',  @select_authentication_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before select_authentication is made visible.
function select_authentication_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for select_authentication
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes select_authentication wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = select_authentication_OutputFcn(hObject, eventdata, handles)
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
one_way_login
closereq()


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
two_way_login
closereq()

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
