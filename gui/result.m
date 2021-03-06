%function varargout = result(pred_labels,pred_probs,true_labels,metrics)
function varargout = result(varargin)
% RESULT MATLAB code for result.fig
%      RESULT, by itself, creates a new RESULT or raises the existing
%      singleton*.
%
%      H = RESULT returns the handle to a new RESULT or the handle to
%      the existing singleton*.
%
%      RESULT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULT.M with the given input arguments.
%
%      RESULT('Property','Value',...) creates a new RESULT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before result_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to result_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help result

% Last Modified by GUIDE v2.5 19-Mar-2018 15:11:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @result_OpeningFcn, ...
                   'gui_OutputFcn',  @result_OutputFcn, ...
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


% --- Executes just before result is made visible.
function result_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to result (see VARARGIN)

% Choose default command line output for result
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

%set(handles.acc_text,'String',varargin{1});
% UIWAIT makes result wait for user response (see UIRESUME)
% uiwait(handles.figure1);
pred_labels = varargin{1};
pred_probs = varargin{2};
true_labels = varargin{3};
metrics = varargin{4};
addpath('../model');
[~,~,acc] = jb_SensitivitySpecificity(pred_labels,true_labels);
set(handles.acc_text,'String',acc);

%roc curve
[auc,X,Y] = plot_roc(pred_probs,true_labels,false);
axes(handles.roc_axes);
plot(X,Y,'-ro','LineWidth',2,'MarkerSize',3);  
axis([0,1,0,1]);
xlabel('False Positive Rate');  
ylabel('True Positive Rate');  
title('ROC curve'); 
set(handles.auc_text,'String',auc);

%P-R curve
[precision,recall] = plot_pr(pred_probs,true_labels,false);
axes(handles.pr_axes);
plot(recall,precision,'-ro','LineWidth',2,'MarkerSize',3);
axis([0,1,0,1]);
xlabel('Recall');  
ylabel('Precison');  
title('P-R curve');  

% --- Outputs from this function are returned to the command line.
function varargout = result_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
