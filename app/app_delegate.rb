class AppDelegate
  attr_accessor :status_menu

  APPLICATION_ID = 'Apple Global Domain'
  APPLICATION_KEY = 'NSPreferredSpellServerLanguage'

  LANGUAGES = {
    'en' => 'English',
    'es' => 'Spanish'
  }

  def applicationDidFinishLaunching(notification)
    @app_name = NSBundle.mainBundle.infoDictionary['CFBundleDisplayName']
    @status_menu = NSMenu.new

    @status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength).init
    @status_item.setMenu(@status_menu)
    @status_item.setHighlightMode(true)
    @status_item.setTitle(activeLanguage.upcase)

    LANGUAGES.each do |key, label|
      @status_menu.addItem createMenuItem(label, "changeTo#{label}")
    end

    @status_menu.addItem NSMenuItem.separatorItem

    @status_menu.addItem createMenuItem("License", 'orderFrontStandardAboutPanel:')
    @status_menu.addItem createMenuItem("Quit", 'terminate:')

  end

  def createMenuItem(name, action)
    NSMenuItem.alloc.initWithTitle(name, action: action, keyEquivalent: '')
  end

  def changeToEnglish
    writeLanguagePreference('en')
    @status_item.setTitle('EN')
  end

  def changeToSpanish
    writeLanguagePreference('es')
    @status_item.setTitle('ES')
  end

  def writeLanguagePreference(language)
    CFPreferencesSetAppValue(APPLICATION_KEY, language, APPLICATION_ID)
    CFPreferencesAppSynchronize(APPLICATION_ID)
  end

  def activeLanguage
    CFPreferencesCopyAppValue(APPLICATION_KEY, APPLICATION_ID)
  end
end
