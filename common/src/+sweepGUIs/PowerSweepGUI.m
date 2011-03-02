function settings_fcn = PowerSweepGUI(parent, bottom, left, name)
% POWERSWEEP_BUILD
%-------------------------------------------------------------------------------
% File name   : PowerSweep_build.m            
% Generated on: 15-Oct-2010 15:06:37          
% Description :
%-------------------------------------------------------------------------------


% Initialize handles structure
handles = struct();


% if there is no parent figure given, generate one
if nargin < 1 || ~isnumeric(parent)
	handles.figure1 = figure( ...
			'Tag', 'figure1', ...
			'Units', 'characters', ...
			'Position', [103.833333333333 13.8571428571429 78 12], ...
			'Name', 'Power Settings', ...
			'MenuBar', 'none', ...
			'NumberTitle', 'off', ...
			'Color', get(0,'DefaultUicontrolBackgroundColor'));
	
	left = 10.0;
	bottom = 10.0;
	name = ['Power settomgs'];
else
	handles.figure1 = parent;
	name = ['Power settings ' name];
end

% Create all UI controls
build_gui();

% Assign function output
settings_fcn = @get_settings;

%% ---------------------------------------------------------------------------
	function build_gui()
% Creation of all uicontrols

		% --- PANELS -------------------------------------
		handles.powpanel1 = uipanel( ...
			'Parent', handles.figure1, ...
			'Tag', 'powpanel1', ...
			'Units', 'pixels', ...
			'Position', [left bottom 425 115], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'Title', name);

		% --- STATIC TEXTS -------------------------------------
		handles.text1 = uicontrol( ...
			'Parent', handles.powpanel1, ...
			'Tag', 'text1', ...
			'Style', 'text', ...
			'Units', 'characters', ...
			'Position', [6.8 2.23076923076923 12 1.07692307692308], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Start power');

		handles.text2 = uicontrol( ...
			'Parent', handles.powpanel1, ...
			'Tag', 'text2', ...
			'Style', 'text', ...
			'Units', 'characters', ...
			'Position', [29 2.23076923076923 11.8 1.07692307692308], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Stop power');

		handles.text3 = uicontrol( ...
			'Parent', handles.powpanel1, ...
			'Tag', 'text3', ...
			'Style', 'text', ...
			'Units', 'characters', ...
			'Position', [46.4 2.23076923076923 21 1.07692307692308], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Step');

		handles.text4 = uicontrol( ...
			'Parent', handles.powpanel1, ...
			'Tag', 'text4', ...
			'Style', 'text', ...
			'Units', 'characters', ...
			'Position', [11.2 5.46153846153846 12.8 1.07692307692308], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Generator ID');

		handles.text6 = uicontrol( ...
			'Parent', handles.powpanel1, ...
			'Tag', 'text6', ...
			'Style', 'text', ...
			'Units', 'characters', ...
			'Position', [41.2 5.46153846153846 12.8 1.07692307692308], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'units');

		% --- EDIT TEXTS -------------------------------------
		handles.powStart = uicontrol( ...
			'Parent', handles.powpanel1, ...
			'Tag', 'powStart', ...
			'Style', 'edit', ...
			'Units', 'characters', ...
			'Position', [2.8 0.692307692307692 19.4 1.53846153846154], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', '-50');

		handles.powStop = uicontrol( ...
			'Parent', handles.powpanel1, ...
			'Tag', 'powStop', ...
			'Style', 'edit', ...
			'Units', 'characters', ...
			'Position', [25 0.692307692307692 19.4 1.53846153846154], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', '-50');

		handles.powStep = uicontrol( ...
			'Parent', handles.powpanel1, ...
			'Tag', 'powStep', ...
			'Style', 'edit', ...
			'Units', 'characters', ...
			'Position', [47.8 0.692307692307692 19.4 1.53846153846154], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', '1');

		% --- POPUP MENU -------------------------------------
		handles.genID = uicontrol( ...
			'Parent', handles.powpanel1, ...
			'Tag', 'genIDpow', ...
			'Style', 'popupmenu', ...
			'Units', 'characters', ...
			'Position', [7.4 3.76923076923077 19 1.61538461538462], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', {'RF','LO','Spec','Spec2'});

		handles.powerUnits = uicontrol( ...
			'Parent', handles.powpanel1, ...
			'Tag', 'powerUnits', ...
			'Style', 'popupmenu', ...
			'Units', 'characters', ...
			'Position', [38.8 3.76923076923077 19 1.61538461538462], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', {'dBm','mW'});


	end

	function selected = get_selected(hObject)
		menu = get(hObject,'String');
		selected = menu{get(hObject,'Value')};
	end

	function value = get_numeric(hObject)
		value = str2num(get(hObject, 'String'));
	end

	function settings = get_settings()
		settings = struct();
		
		settings.type = 'sweeps.Power';
		settings.start = get_numeric(handles.powStart);
		settings.stop = get_numeric(handles.powStop);
		settings.step = get_numeric(handles.powStep);
		settings.units = get_selected(handles.powerUnits);
		settings.genID = [get_selected(handles.genID) 'gen'];
	end

end
