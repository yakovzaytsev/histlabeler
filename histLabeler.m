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

% Last Modified by GUIDE v2.5 17-Nov-2017 22:33:01

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
handles.p = 0;
%handles.maxslider.Callback = @(slider,evdata) updateSlider(handles.axes1, slider, handles.maxedit, handles.minedit, handles.maxedit, handles);
%handles.minslider.Callback = @(slider,evdata) updateSlider(handles.axes1, slider, handles.minedit, handles.minedit, handles.maxedit, handles);

RGB = imread('/Users/ysz/MATLAB/meter/0_b_meter.jpg');
I = rgb2gray(RGB);

green = cat(3, zeros(size(I)), ones(size(I)), zeros(size(I)));
axes(handles.axesmask);
g = imshow(green);
tmp = zeros(size(I));
tmp(:) = 0.5;
set(g, 'AlphaData', tmp);

handles.I = I;
axes(handles.axes2);
imshow(I);
axes(handles.axes1);
imhist(I);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes histLabeler wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = histLabeler_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function updateSlider(hObject, edit, handles)
slider = hObject;
x = round(250 * slider.Value);

set(edit, 'string',sprintf('%d', x));

% XXX
min = str2num(get(handles.minedit, 'string'));
max = str2num(get(handles.maxedit, 'string'));

fprintf('%d - %d\n', min, max);

axes(handles.axes1);
maxy = ylim;
x = [min, min, max, max];
y = [0,maxy(2),maxy(2),0];
if handles.p ~= 0
    delete(handles.p);
end
handles.p = patch(x,y,'g');
set(handles.p,'FaceAlpha',0.5);

tmp = thresholdHist(handles.I, min, max);
%green = cat(3, zeros(size(I)), ones(size(I)), zeros(size(I)));
axes(handles.axes2);
%r(ROI) = 1;
%mask = cat(3, r, g, b);
cla;
%hold on;
%imshow(green);
%hold off;

h = imshow(handles.I);

%[M, N] = size(handles.I);
%alpha = zeros(M, N);
%alpha(:) = 0.2;

set(h, 'AlphaData', tmp);

guidata(hObject,handles);


% --- Executes on slider movement.
function maxslider_Callback(hObject, eventdata, handles)
% hObject    handle to maxslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateSlider(hObject, handles.maxedit, handles);

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
updateSlider(hObject, handles.minedit, handles);

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmp = ones(size(handles.I));
tmp(handles.ROI) = 0;
imwrite(tmp,'/tmp/out.png');