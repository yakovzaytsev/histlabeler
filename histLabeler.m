function varargout = histLabeler(varargin)
% HISTLABELER MATLAB code for histLabeler.fig
%      HISTLABELER, by itself, creates a new HISTLABELER or raises the existing
%      singleton*.
%
%      H = HISTLABELER returns the handle to a new HISTLABELER or the handle to
%      the existing singleton*.
%
%      HISTLABELER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HISTLABELER.M with the given input arguments.
%
%      HISTLABELER('Property','Value',...) creates a new HISTLABELER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before histLabeler_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to histLabeler_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help histLabeler

% Last Modified by GUIDE v2.5 17-Nov-2017 17:46:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @histLabeler_OpeningFcn, ...
                   'gui_OutputFcn',  @histLabeler_OutputFcn, ...
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


% --- Executes just before histLabeler is made visible.
function histLabeler_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to histLabeler (see VARARGIN)

% Choose default command line output for histLabeler
handles.output = hObject;
handles.maxslider.Callback = @(slider,evdata) updateSlider(handles.axes1, slider, handles.maxedit, handles.minedit, handles.maxedit);
handles.minslider.Callback = @(slider,evdata) updateSlider(handles.axes1, slider, handles.minedit, handles.minedit, handles.maxedit);
RGB = imread('/Users/ysz/MATLAB/meter/0_b_meter.jpg');
axes(handles.axes2);
I = rgb2gray(RGB);
imshow(I);
axes(handles.axes1);
imhist(I);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes histLabeler wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function updateSlider(axes1, slider, edit, minedit, maxedit)
%axes(axes1);
x = round(250 * slider.Value);
set(edit, 'string',sprintf('%d', x));

% XXX
min = get(minedit, 'string');
max = get(maxedit, 'string');

fprintf('%s - %s\n', min, max);


% --- Outputs from this function are returned to the command line.
function varargout = histLabeler_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function maxslider_Callback(hObject, eventdata, handles)
% hObject    handle to maxslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function maxslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function minslider_Callback(hObject, eventdata, handles)
% hObject    handle to minslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function minslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function maxedit_Callback(hObject, eventdata, handles)
% hObject    handle to maxedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxedit as text
%        str2double(get(hObject,'String')) returns contents of maxedit as a double


% --- Executes during object creation, after setting all properties.
function maxedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minedit_Callback(hObject, eventdata, handles)
% hObject    handle to minedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minedit as text
%        str2double(get(hObject,'String')) returns contents of minedit as a double


% --- Executes during object creation, after setting all properties.
function minedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
