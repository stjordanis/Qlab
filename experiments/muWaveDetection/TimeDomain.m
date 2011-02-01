%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Module Name :  TimeDomain.m
 %
 % Author/Date : Blake Johnson / October 19, 2010
 %
 % Description : A GUI sweeper for homodyneDetection2D.
 %
 % Version: 1.0
 %
 %    Modified    By    Reason
 %    --------    --    ------
 %
 %
 % Copyright 2010 Raytheon BBN Technologies
 %
 % Licensed under the Apache License, Version 2.0 (the "License");
 % you may not use this file except in compliance with the License.
 % You may obtain a copy of the License at
 %
 %     http://www.apache.org/licenses/LICENSE-2.0
 %
 % Unless required by applicable law or agreed to in writing, software
 % distributed under the License is distributed on an "AS IS" BASIS,
 % WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 % See the License for the specific language governing permissions and
 % limitations under the License.
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function status = TimeDomain(cfg_file_name)
% This script will execute a time domain (2D) experiment using the
% default parameters found in the cfg file or specified using the GUI.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%     CLEAR      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% close open instruments
temp = instrfind;
if ~isempty(temp)
    fclose(temp);
    delete(temp)
end
clear temp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%     BASIC INPUTS      %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% base_path is up two levels from this file
[base_path] = fileparts(mfilename('fullpath'));
base_path = parent_dir(base_path, 2);

data_path = [base_path '/experiments/muWaveDetection/data/'];
cfg_path = [base_path '/experiments/muWaveDetection/cfg/'];
basename = 'TimeDomain';

if nargin < 1
	cfg_file_name = [cfg_path 'homodyneDetection_v1_005.cfg'];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%     INITIALIZE PATH     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%restoredefaultpath
addpath([ base_path '/experiments/muWaveDetection/'],'-END');
addpath([ base_path '/common/src'],'-END');
addpath([ base_path '/experiments/muWaveDetection/src'],'-END');
addpath([ base_path '/common/src/util/'],'-END');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%     CREATE GUI     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mainWindow = figure( ...
	'Tag', 'figure1', ...
	'Units', 'pixels', ...
	'Position', [25 25 1250 800], ...
	'Name', 'TimeDomain', ...
	'MenuBar', 'none', ...
	'NumberTitle', 'off', ...
	'Color', get(0,'DefaultUicontrolBackgroundColor'), ...
	'Visible', 'off');

% get previous settings
cfg_name = [cfg_path 'lastRun.cfg'];
if exist(cfg_name, 'file')
	prevSettings = parseParamFile([cfg_path 'TimeDomain_lastRun.cfg']);
else
	prevSettings = struct();
	prevSettings.InstrParams = struct();
end
% make sure it has fields for current set of instruments
instrumentNames = {'scope', 'RFgen', 'LOgen', 'Specgen', 'TekAWG', 'BBNdc'};
for f = instrumentNames
	name = cell2mat(f);
	if ~isfield(prevSettings.InstrParams, name)
		prevSettings.InstrParams.(name) = struct();
	end
end

% add instrument panels
get_acqiris_settings = deviceGUIs.acqiris_settings_gui(mainWindow, 10, 155, prevSettings.InstrParams.scope);

% create tab group for microwave sources
muWaveTabGroupPanel = uipanel('parent', mainWindow, ...
	'units', 'pixels', 'position', [350, 490, 405, 290]);
muWaveTabGroup = uitabgroup('parent', muWaveTabGroupPanel, ...
	'units', 'pixels', 'position', [2, 2, 400, 285]);
RFtab = uitab('parent', muWaveTabGroup, 'title', 'RF');
LOtab = uitab('parent', muWaveTabGroup, 'title', 'LO');
Spectab = uitab('parent', muWaveTabGroup, 'title', 'Spec');

get_rf_settings = deviceGUIs.uW_source_settings_GUI(RFtab, 10, 10, 'RF', prevSettings.InstrParams.RFgen);
get_lo_settings = deviceGUIs.uW_source_settings_GUI(LOtab, 10, 10, 'LO', prevSettings.InstrParams.LOgen);
get_spec_settings = deviceGUIs.uW_source_settings_GUI(Spectab, 10, 10, 'Spec', prevSettings.InstrParams.Specgen);

% add AWGs
get_tekAWG_settings = deviceGUIs.AWG5014_settings_GUI(mainWindow, 240, 350, 'TekAWG', prevSettings.InstrParams.TekAWG);

% add DC sources
get_DCsource_settings = deviceGUIs.DCBias_settings_GUI(mainWindow, 240, 775, prevSettings.InstrParams.BBNdc);

% add digital Homodyne
get_digitalHomodyne_settings = digitalHomodyne_GUI(mainWindow, 140, 350);

% add filter settings
get_boxcarFilter_settings = boxcarFilter_GUI(mainWindow, 50, 350);

% add tab group for sweeps
sweepsTabGroupPanel = uipanel('parent', mainWindow, ...
	'units', 'pixels', 'position', [775, 620, 440, 160]);
sweepsTabGroup = uitabgroup('parent', sweepsTabGroupPanel, ...
	'units', 'pixels', 'position', [2, 2, 430, 160]);
FreqAtab = uitab('parent', sweepsTabGroup, 'title', 'Freq A');
Powertab = uitab('parent', sweepsTabGroup, 'title', 'Power');
Phasetab = uitab('parent', sweepsTabGroup, 'title', 'Phase');
DCtab = uitab('parent', sweepsTabGroup, 'title', 'DC');

get_freqA_settings = sweepGUIs.FrequencySweepGUI(FreqAtab, 5, 2, 'A');
get_power_settings = sweepGUIs.PowerSweepGUI(Powertab, 5, 2, '');
get_phase_settings = sweepGUIs.PhaseSweepGUI(Phasetab, 5, 2, '');
get_dc_settings = sweepGUIs.DCSweepGUI(DCtab, 5, 2, '');

% add sweep/loop selector
fastLoop = labeledDropDown(mainWindow, [775 550 120 25], 'Fast Loop', ...
	{'frequencyA', 'power', 'phase', 'dc', 'nothing'});

% add file path selector
get_path = path_selector(mainWindow, [910 525 250 25]);

% add soft averages control
softAvgs = uicontrol(mainWindow, ...
    'Style', 'edit', ...
    'String', '1', ...
    'Position', [775 495 100 25]);

% soft avgs label
uicontrol(mainWindow, 'Style' ,'text', 'String', 'Soft Avgs', 'Position', [775 520 100 25]);

% add run button
runHandle = uicontrol(mainWindow, ...
	'Style', 'pushbutton', ...
	'String', 'Run', ...
	'Position', [50 50, 75, 30], ...
	'Callback', {@run_callback});

% show mainWindow
drawnow;
set(mainWindow, 'Visible', 'on');

% add run callback

	function run_callback(hObject, eventdata)

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%%%%%%%%%%%%%%%%%%%%%     WRITE CONFIG     %%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		% construct settings cluster
		settings = struct();
		
		% get instrument settings
		settings.InstrParams.scope = get_acqiris_settings();
		settings.InstrParams.RFgen = get_rf_settings();
		settings.InstrParams.LOgen = get_lo_settings();
		settings.InstrParams.Specgen = get_spec_settings();
		settings.InstrParams.TekAWG = get_tekAWG_settings();
		settings.InstrParams.BBNdc = get_DCsource_settings();
		
		% get sweep settings
		settings.SweepParams.frequencyA = get_freqA_settings();
		settings.SweepParams.power = get_power_settings();
		settings.SweepParams.phase = get_phase_settings();
		settings.SweepParams.dc = get_dc_settings();
		% add 'nothing' sweep
		settings.SweepParams.nothing = struct('type', 'sweeps.Nothing');
		
		% label fast and slop loops as sweeps 1 and 2
		settings.SweepParams.(get_selected(fastLoop)).number = 1;
		
		% get other experiment settings
		settings.ExpParams.digitalHomodyne = get_digitalHomodyne_settings();
        settings.ExpParams.filter = get_boxcarFilter_settings();
        settings.ExpParams.softAvgs = str2double(get(softAvgs, 'String'));
		settings.displayScope = 1;
		settings.SoftwareDevelopmentMode = 0;
        
        % get file path
        [tempbasename, temppath] = get_path();
        if ~strcmp(temppath, '')
            data_path = temppath;
            basename = tempbasename;
        end
        %basename = [basename '_' datestr(now(),30)];
		new_cfg_file_name = [cfg_path 'TimeDomain_lastRun.cfg'];
		writeCfgFromStruct(new_cfg_file_name, settings);

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%%%%%%%%%%%%%%%%%     PREPARE FOR EXPERIMENT      %%%%%%%%%%%%%%%%%%%%%%%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% These methods are inherited from the superclass 'experiment'.  They are
		% generic for all Experiments
		Exp = expManager.homodyneDetection2D(data_path, new_cfg_file_name, basename);
		Exp.parseExpcfgFile;

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%%%%%%%%%%%%%%%%%%%     RUN THE EXPERIMENT      %%%%%%%%%%%%%%%%%%%%%%%%%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		% Initialize the data file and record the parameters
		Exp.openDataFile;
		Exp.writeDataFileHeader;

		% Run the actual experiment
		Exp.Init;
		Exp.Do;
		Exp.CleanUp;

		% Close the data file and end connection to all insturments.  This is 
		% another method inherited from 'experiment'
		Exp.finalizeData;

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%%%%%%%%%%%%%%     PRINT DATA AND CHECK HEADER      %%%%%%%%%%%%%%%%%%%%%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		% Now we print the output file (header and data) to the command prompt
		% fprintf('\nStart of Data Output File print out\n');
		% type(Exp.DataFileName);
		% fprintf('\nEnd of Data Output File print out\n\n');

		% Now we can parse the header to recover the inputStructure
% 		Exp.parseDataFile;
% 		headerStructure = Exp.DataStruct.params;
% 
% 		% This function will compare the two structures and make sure that they
% 		% match.
% 		[HeaderFields InputFields err] = comp_struct(headerStructure,Exp.inputStructure,...
% 			'headerStructure','Exp.inputStructure');
% 
% 		if isempty(err)
% 			fprintf('\nSucess: inputStructure matches header data\n');
% 		else
% 			fprintf('\ninputStructure does not match header data\n');
% 			display(HeaderFields);display(InputFields);display(err);
% 		end

		status = 0;
	end

end

% find the nth parent of directory given in 'path'
function str = parent_dir(path, n)
	str = path;
	if nargin < 2
		n = 1
	end
	for j = 1:n
		pos = find(str == filesep, 1, 'last');
		str = str(1:pos-1);
	end
end