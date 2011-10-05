function setting_fcn = uW_source_settings_GUI(parent, bottom, left, name, settings)
% UW_SOURCE_SETTINGS_GUI_BUILD
%-------------------------------------------------------------------------------
% File name   : uW_source_settings_GUI_build.m
% Generated on: 06-Oct-2010 14:36:30          
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
			'Name', 'uW_settings', ...
			'MenuBar', 'none', ...
			'NumberTitle', 'off', ...
			'Color', get(0,'DefaultUicontrolBackgroundColor'));
	
	left = 10.0;
	bottom = 10.0;
	name = ['uW' ' source settings'];
else
	%handles.figure1 = figure(parent);
	handles.figure1 = parent;
	name = [name ' source settings'];
end

% Create all UI controls
build_gui();

if nargin < 5
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
			'UserData', zeros(1,0), ...
			'Units', 'pixels', ...
			'Position', [left bottom 373 239], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'Title', name);

		% --- STATIC TEXTS -------------------------------------
		handles.text2 = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'text2', ...
			'UserData', zeros(1,0), ...
			'Style', 'text', ...
			'Units', 'normalized', ...
			'Position', [0.612377850162869 0.405186740138197 0.143322475570033 0.0679611650485437], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Q Offset', ...
			'HorizontalAlignment', 'left');

		handles.text3 = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'text3', ...
			'UserData', zeros(1,0), ...
			'Style', 'text', ...
			'Units', 'normalized', ...
			'Position', [0.392953929539295 0.405405405405405 0.157181571815718 0.0675675675675676], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'I Offset', ...
			'HorizontalAlignment', 'left');

		handles.text4 = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'text4', ...
			'UserData', zeros(1,0), ...
			'Style', 'text', ...
			'Units', 'normalized', ...
			'Position', [0.0542005420054201 0.432432432432432 0.197831978319783 0.0720720720720721], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Phase (deg)', ...
			'HorizontalAlignment', 'left');

		handles.text5 = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'text5', ...
			'UserData', zeros(1,0), ...
			'Style', 'text', ...
			'Units', 'normalized', ...
			'Position', [0.0521172638436482 0.658619784833377 0.218241042345277 0.0679611650485437], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Power (dBm)', ...
			'HorizontalAlignment', 'left');

		handles.text6 = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'text6', ...
			'UserData', zeros(1,0), ...
			'Style', 'text', ...
			'Units', 'normalized', ...
			'Position', [0.0514905149051491 0.869369369369369 0.289972899728997 0.0675675675675676], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Frequency (GHz)', ...
			'HorizontalAlignment', 'left');

		handles.text7 = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'text7', ...
			'UserData', zeros(1,0), ...
			'Style', 'text', ...
			'Units', 'normalized', ...
			'Position', [0.422764227642276 0.18018018018018 0.289972899728997 0.0675675675675676], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Model', ...
			'HorizontalAlignment', 'left');

		handles.text1 = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'text1', ...
			'UserData', zeros(1,0), ...
			'Style', 'text', ...
			'Units', 'normalized', ...
			'Position', [0.82084690553746 0.405186740138197 0.140065146579805 0.0679611650485437], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'IQ Skew', ...
			'HorizontalAlignment', 'left');

		handles.gpib_address_label = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'gpib_address', ...
			'UserData', zeros(1,0), ...
			'Style', 'text', ...
			'Units', 'normalized', ...
			'Position', [0.0569105691056911 0.18018018018018 0.289972899728997 0.0675675675675676], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'GPIB Address', ...
			'HorizontalAlignment', 'left');

		% --- RADIO BUTTONS -------------------------------------
		handles.alc = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'alc1', ...
			'UserData', zeros(1,0), ...
			'Style', 'radiobutton', ...
			'Units', 'normalized', ...
			'Position', [0.775244299674269 0.744424035686172 0.159609120521173 0.111650485436893], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'ALC');

		handles.iqadjust = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'iqadjust1', ...
			'UserData', zeros(1,0), ...
			'Style', 'radiobutton', ...
			'Units', 'normalized', ...
			'Position', [0.411924119241192 0.486486486486486 0.235772357723577 0.112612612612613], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'IQ Adjust');

		handles.pulse = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'pulse1', ...
			'UserData', zeros(1,0), ...
			'Style', 'radiobutton', ...
			'Units', 'normalized', ...
			'Position', [0.409876150878773 0.61987229948395 0.172638436482085 0.111650485436893], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Pulse');

		handles.mod = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'mod1', ...
			'UserData', zeros(1,0), ...
			'Style', 'radiobutton', ...
			'Units', 'normalized', ...
			'Position', [0.579804560260588 0.744424035686172 0.153094462540717 0.111650485436893], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Mod');

		handles.rf = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'rf1', ...
			'UserData', zeros(1,0), ...
			'Style', 'radiobutton', ...
			'Units', 'normalized', ...
			'Position', [0.41042345276873 0.744424035686172 0.13029315960912 0.111650485436893], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'RF');

		% --- CHECKBOXES -------------------------------------
		handles.enable = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'enable1', ...
			'UserData', zeros(1,0), ...
			'Style', 'checkbox', ...
			'Units', 'normalized', ...
			'Position', [0.791327913279133 0.0630630630630631 0.192411924119241 0.112612612612613], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'String', 'Enable');

		% --- EDIT TEXTS -------------------------------------
		handles.phase = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'phase1', ...
			'UserData', zeros(1,0), ...
			'Style', 'edit', ...
			'Units', 'normalized', ...
			'Position', [0.0542005420054201 0.324324324324324 0.159891598915989 0.0990990990990991], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', '0', ...
			'HorizontalAlignment', 'right');

		handles.power = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'power1', ...
			'UserData', zeros(1,0), ...
			'Style', 'edit', ...
			'Units', 'normalized', ...
			'Position', [0.0521172638436482 0.542114930464445 0.159609120521173 0.0970873786407767], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', '-110', ...
			'HorizontalAlignment', 'right');

		handles.freq = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'freq1', ...
			'UserData', zeros(1,0), ...
			'Style', 'edit', ...
			'Units', 'normalized', ...
			'Position', [0.0521172638436482 0.751902387824718 0.325732899022801 0.0970873786407767], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', '10.0', ...
			'HorizontalAlignment', 'right');

		handles.skew = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'skew1', ...
			'UserData', zeros(1,0), ...
			'Style', 'edit', ...
			'Units', 'normalized', ...
			'Position', [0.817589576547232 0.291437068136097 0.159609120521173 0.0970873786407767], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', '0');

		handles.qoffset = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'qoffset1', ...
			'UserData', zeros(1,0), ...
			'Style', 'edit', ...
			'Units', 'normalized', ...
			'Position', [0.612377850162866 0.291650186772138 0.169381107491857 0.0975609756097561], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', '0');

		handles.ioffset = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'ioffset1', ...
			'UserData', zeros(1,0), ...
			'Style', 'edit', ...
			'Units', 'normalized', ...
			'Position', [0.387622149837134 0.291650186772138 0.182410423452769 0.0975609756097561], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', '0');

		handles.gpib_address = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'gpib_address', ...
			'UserData', zeros(1,0), ...
			'Style', 'edit', ...
			'Units', 'normalized', ...
			'Position', [0.0569105691056911 0.0630630630630631 0.32520325203252 0.0990990990990991], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', '', ...
			'HorizontalAlignment', 'right');

		% --- POPUP MENU -------------------------------------
		handles.pulsetype = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'pulsetype1', ...
			'UserData', zeros(1,0), ...
			'Style', 'popupmenu', ...
			'Units', 'normalized', ...
			'Position', [0.594475781891371 0.620572028339019 0.322475570032573 0.101941747572816], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', {'External','Internal'});

		handles.gen_model = uicontrol( ...
			'Parent', handles.uipanel1, ...
			'Tag', 'gen1ID', ...
			'UserData', zeros(1,0), ...
			'Style', 'popupmenu', ...
			'Units', 'normalized', ...
			'Position', [0.422764227642276 0.0630630630630631 0.322493224932249 0.103603603603604], ...
			'FontName', 'Helvetica', ...
			'FontSize', 10, ...
			'BackgroundColor', [1 1 1], ...
			'String', {'AgilentN5183A','AgilentE8267D','AnritsuMG3692B','HP8673B','HP8340B','Labbrick'});


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
		settings.deviceName = get_selected(handles.gen_model);
		settings.Address = get_numeric(handles.gpib_address);
		settings.frequency = get_numeric(handles.freq);
		settings.power = get_numeric(handles.power);
		settings.phase = get_numeric(handles.phase);
		settings.output = get(handles.rf, 'Value');
		settings.mod = get(handles.mod, 'Value');
		settings.alc = get(handles.alc, 'Value');
		settings.pulse = get(handles.pulse, 'Value');
		settings.pulsemode = get_selected(handles.pulsetype);
		settings.iqadjust = get(handles.iqadjust, 'Value');
		settings.ioffset = get_numeric(handles.ioffset);
		settings.qoffset = get_numeric(handles.qoffset);
		settings.iqskew = get_numeric(handles.skew);
		
	end

	function set_defaults(settings)
		% define default values for fields. If given a settings structure, grab
		% defaults from it
		defaults = struct();
		defaults.frequency = 10.0;
		defaults.power = -110;
		defaults.phase = 0;
		defaults.Address = '';
		defaults.deviceName = 'AgilentN5183A';
		defaults.enable = 0;
		defaults.output = 0;
		defaults.mod = 0;
		defaults.alc = 0;
		defaults.pulse = 0;
		defaults.pulsemode = 'External';
		defaults.iqadjust = 0;
		defaults.ioffset = 0;
		defaults.qoffset = 0;
		defaults.iqskew = 0;

		if ~isempty(fieldnames(settings))
			fields = fieldnames(settings);
			for i = 1:length(fields)
				name = fields{i};
				defaults.(name) = settings.(name);
			end
		end
		
		set(handles.enable, 'Value', defaults.enable);
		set(handles.gpib_address, 'String', num2str(defaults.Address));
		set_selected(handles.gen_model, defaults.deviceName);
		set(handles.freq, 'String', num2str(defaults.frequency));
		set(handles.power, 'String', num2str(defaults.power));
		set(handles.phase, 'String', num2str(defaults.phase));
		set(handles.rf, 'Value', defaults.output);
		set(handles.mod, 'Value', defaults.mod);
		set(handles.alc, 'Value', defaults.alc);
		set(handles.pulse, 'Value', defaults.pulse);
		set_selected(handles.pulsetype, defaults.pulsemode);
		set(handles.iqadjust, 'Value', defaults.iqadjust);
		set(handles.ioffset, 'String', num2str(defaults.ioffset));
		set(handles.qoffset, 'String', num2str(defaults.qoffset));
		set(handles.skew, 'String', num2str(defaults.iqskew));
	end

end
