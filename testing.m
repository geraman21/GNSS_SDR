processingResults = load('successTracking.mat');
settings = initSettings();

%%disp(settings)
%% Calculate navigation solutions =========================================
    disp('   Calculating navigation solutions...');
    [navSolutions, eph] = postNavigation(processingResults.trackResults, settings);

    disp('   Processing is complete for this data block');

%% Plot all results ===================================================
    disp ('   Ploting results...');
    if settings.plotTracking
       % plotTracking(1:settings.numberOfChannels, processingResults.trackResults, settings);
    end

    %plotNavigation(navSolutions, settings);

    disp('Post processing of the signal is over.');
