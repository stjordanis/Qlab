function setting_fcn = Yoko7651_GUI(parent, bottom, left, settings)
% YOKO7651_BUILD
%-------------------------------------------------------------------------------
% File name   : Yoko7651_GUI.m              
% Generated on: 15-Nov-2010 16:30:50          
% Description :
%-------------------------------------------------------------------------------
% Initialize handles structure
handles = struct();

% if there is no parent figure given, generate one
if nargin < 1 || ~isnumeric(parent)
	handles.figure1 = figure( ...
			'Tag', 'figure1', ...
			'Units', 'characters', ...
			'Position', [103.833333333333 13.8571428571429 90 22], ...
			'Name', 'Yoko settings', ...
			'MenuBar', 'none', ...
			'NumberTitle', 'off', ...
			'Color', get(0,'DefaultUicontrolBackgroundColor'));
	
	left = 10.0;
	bottom = 10.0;
else
	handles.figure1 = parent;
end
name = 'Yoko Settings';

% Create all UI controls
build_gui();

if nargin < 4
	settings = struct();
end
set_defaults(settings);

% Assign function output
setting_fcn = @get_settings;

%% ---------------------------------------------------------------------------
	function build_gui()
% Creation of all uicontrols

		% --- PANELS -------------------------------------
		handles.uipanel1 = uipanel( ...
			'Parent', handles.figure1, ...
			'Tag', 'uipanel1', ...
			'Units', 'pixels', ...
			'Position', [left bottom 425 110], ...
			'Title', name);

		% --- STATIC TEXTS -------------------------------------
		handles.popupmenu2 = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'popupmenu2', ...
			'Style', 'text', ...
			'Units', 'characters', ...
			'Position', [4 6.32967032967033 18.2 1], ...
			'String', 'Voltage Range');

		handles.text17 = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'text17', ...
			'Style', 'text', ...
			'Units', 'characters', ...
			'Position', [18.8 2.86813186813187 15 1], ...
			'String', 'GPIB Address');

		handles.text18 = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'text18', ...
			'Style', 'text', ...
			'Units', 'characters', ...
			'Position', [24.8 6.17582417582418 20 1.15384615384615], ...
			'String', 'Setpoint (V)');

		% --- RADIO BUTTONS -------------------------------------
		handles.output = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'output', ...
			'Style', 'radiobutton', ...
			'Units', 'characters', ...
			'Position', [48.4 4.79120879120879 14.8 1.23076923076923], ...
			'String', 'Output On');

		% --- CHECKBOXES -------------------------------------
		handles.enable = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'enable', ...
			'Style', 'checkbox', ...
			'Units', 'characters', ...
			'Position', [49 1.38461538461538 11.6 1.23076923076923], ...
			'String', 'Enable');

		% --- EDIT TEXTS -------------------------------------
		handles.value = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'value', ...
			'Style', 'edit', ...
			'Units', 'pixels', ...
			'Position', [144 59.2857142857143 50 22], ...
			'BackgroundColor', [1 1 1], ...
			'String', '1');

		handles.Address = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'Address', ...
			'Style', 'edit', ...
			'Units', 'characters', ...
			'Position', [19 1.17582417582418 15 1.53846153846154], ...
			'BackgroundColor', [1 1 1], ...
			'String', '');

		% --- POPUP MENU -------------------------------------
		handles.range = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'range', ...
			'Style', 'popupmenu', ...
			'Units', 'characters', ...
			'Position', [5.33333333333333 4.36813186813186 15.5 1.78571428571429], ...
			'BackgroundColor', [1 1 1], ...
			'String', {'10mV','100mV','1V','10V','30V'});
      
    end
    
    function selected = get_selected(hObject)
		menu = get(hObject,'String');
		selected = menu{get(hObject,'Value')};
	end

	function set_selected(hObject, val)
		menu = get(hObject, 'String');
		index = find(strcmp(val, menu));
		if ~isempty(index)
			set(hObject, 'Value', index);
		end
	end

	function value = get_numeric(hObject)
		value = str2num(get(hObject, 'String'));
	end

	function settings = get_settings()
		settings = struct();
		settings.enable = get(handles.enable, 'Value');
		settings.deviceName = 'Yoko7651';
		settings.Address = get(handles.Address, 'String');
        settings.range = get_selected(handles.range);
        settings.output = get(handles.output, 'Value');
	end

	function set_defaults(settings)
		% define default values for fields. If given a settings structure, grab
		% defaults from it
		defaults.Address = '';
		defaults.enable = 0;
        defaults.value = 0;
        defaults.range = '10mV';
        defaults.output = 0;

		if ~isempty(fieldnames(settings))
			fields = fieldnames(settings);
			for i = 1:length(fields)
				name = fields{i};
				defaults.(name) = settings.(name);
			end
		end
		
		set(handles.enable, 'Value', defaults.enable);
		set(handles.Address, 'String', defaults.Address);
		set_selected(handles.range, defaults.range);
        set(handles.value, 'String',num2str(defaults.value));
        set(handles.output, 'Value', defaults.output);
	end



end