module CountriesAndLanguages
  extend self

  module Helpers
    def countries
      @@countries ||= {}
      @@countries[I18n.locale] ||= CountriesAndLanguages.clean_and_sort(I18nData.countries(I18n.locale.to_s.upcase))
    end

    def country(country_code)
      countries.rassoc(country_code.to_s.upcase)[0] rescue ''
    end

    def languages
      @@languages ||= {}
      @@languages[I18n.locale] ||= CountriesAndLanguages.clean_and_sort(I18nData.languages(I18n.locale.to_s.upcase))
    end

    def language(language_code)
      languages.rassoc(language_code.to_s.upcase)[0] rescue ''
    end
  end

  def clean_and_sort(data)
    data = data.to_a.sort_by{|code,name| name}
    data.map!{|code,name|[clean_name(name),code]}
  end

  def clean_name(name)
    name.sub(/\s*[,;(].*/,'')
  end
end