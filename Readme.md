Countries and languages in I18n.locale
======================================
In currently 85 languages supplied by [I18nData](http://github.com/grosser/i18n_data).<br/>
Languages and countries are stored as iso 639/iso 3166 - 2 letter code.<br/>
Methods are available in views.

    @user.country == 'de'
    @user.language == 'de'

    User is from <%=country(@user.country)%> and speaks <%=language(@user.language)%>
    User is from Germany and speaks German.

    Please select you language <%=f.select_tag(:language,options_for_select(languages))%>
    Select box with all 185 localized languages.

If you have special needs like renaming countries or only displaying a subset,
have a look at the code and overwrite as necessary.

DEMO can be found in [Gettext example application](https://github.com/grosser/gettext_i18n_rails_example)

Install
=====

    gem install countries_and_languages

    # Gemfile
    gem 'countries_and_languages', :require => 'countries_and_languages/rails'

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT
[![Build Status](https://secure.travis-ci.org/grosser/countries_and_languages.png)](http://travis-ci.org/grosser/countries_and_languages)
