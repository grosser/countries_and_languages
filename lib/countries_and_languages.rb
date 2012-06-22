# encoding: UTF-8
require 'i18n_data'

module CountriesAndLanguages
  extend self

  module Helpers
    def countries
      @@countries ||= {}
      @@countries[I18n.locale] ||= CountriesAndLanguages.clean_and_sort(I18nData.countries(I18n.locale.to_s.upcase))
    end

    def country(country_code)
      (countries.rassoc(country_code.to_s.upcase) || [''])[0]
    end

    def languages
      @@languages ||= {}
      @@languages[I18n.locale] ||= CountriesAndLanguages.clean_and_sort(I18nData.languages(I18n.locale.to_s.upcase))
    end

    def language(language_code)
      (languages.rassoc(language_code.to_s.upcase) || [''])[0]
    end
  end

  def clean_and_sort(data)
    data = data.to_a
    data.map!{|code,name| [clean_name(name), code] }
    data.sort_by{|code,name| convert_umlaut_to_base(code) }
  end

  def clean_name(name)
    #General fixes
    name = name.sub(/\s*[,;(].*/,'')

    #German fixes
    name.sub!(/-Sprache$/,'')
    name.sub!(/ Peoples Democratic Republics Democratic Republic/,'')#Lao
    name.sub!(/Demokratische Republik /,'')#Congo

    name
  end

  CONVERSIONS = [
    ['áä', 'a'],
    ['ÁÄÅ', 'A'],
    ['óö', 'o'],
    ['ÓÖ', 'O'],
    ['í', 'i'],
    ['Í', 'I'],
    ['úü', 'u'],
    ['ÚÜ', 'U'],
    ['é', 'e'],
    ['É', 'E'],
    ['ß', 's'],
  ]

  RUBY_18 = RUBY_VERSION < "1.9"

  def convert_umlaut_to_base(input)
    input = input.dup
    if RUBY_18
      old = $KCODE
      $KCODE='u'
      CONVERSIONS.each { |from, to| input.gsub!(/[#{from}]/, to) }
      $KCODE = old
    else
      CONVERSIONS.each { |from, to| input.tr!(from, to) }
    end
    input
  end
end
