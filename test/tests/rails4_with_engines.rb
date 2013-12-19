abort "Please run using test/test.rb" unless defined? BrakemanTester

Rails4WithEngines = BrakemanTester.run_scan "rails4_with_engines", "Rails4WithEngines"

class Rails4WithEnginesTests < Test::Unit::TestCase
  include BrakemanTester::FindWarning
  include BrakemanTester::CheckExpected

  def expected
    @expected ||= {
      :controller => 0,
      :model => 5,
      :template => 11,
      :generic => 6 }
  end

  def report
    Rails4WithEngines
  end

  def test_i18n_xss_CVE_2013_4491
    assert_warning :type => :warning,
      :warning_code => 63,
      :fingerprint => "de0e11056b9f9af7b8570d5354185cd7e17a18cc61d627555fe4adfff00fb447",
      :warning_type => "Cross Site Scripting",
      :message => /^Rails\ 4\.0\.0\ has\ an\ XSS\ vulnerability\ in\ /,
      :confidence => 1,
      :relative_path => "Gemfile"
  end

  def test_number_to_currency_CVE_2013_6415
    assert_warning :type => :warning,
      :warning_code => 65,
      :fingerprint => "813b00b5c58567fb3f32051578b839cb25fc2d827834a30d4b213a4c126202a2",
      :warning_type => "Cross Site Scripting",
      :line => nil,
      :message => /^Rails\ 4\.0\.0\ has\ a\ vulnerability\ in\ numbe/,
      :confidence => 1,
      :relative_path => "Gemfile",
      :user_input => nil
  end

  def test_xss_simple_format_CVE_2013_6416
    assert_warning :type => :template,
      :warning_code => 68,
      :fingerprint => "0e340cc916e7487f118dae7cf3e3c1e6763c13455ec84ad56b4d3f520de8b3cb",
      :warning_type => "Cross Site Scripting",
      :line => 20,
      :message => /^Values\ passed\ to\ simple_format\ are\ not\ s/,
      :confidence => 0,
      :relative_path => "Gemfile",
      :user_input => s(:call, s(:call, s(:const, :User), :find, s(:call, s(:params), :[], s(:lit, :id))), :likes)

    assert_warning :type => :template,
      :warning_code => 68,
      :fingerprint => "33d10865a3c6c1594ecbee5511cde466b474b0e819ef979193159559becfbd4c",
      :warning_type => "Cross Site Scripting",
      :line => 21,
      :message => /^Values\ passed\ to\ simple_format\ are\ not\ s/,
      :confidence => 0,
      :relative_path => "Gemfile",
      :user_input => s(:call, s(:params), :[], s(:lit, :color))
  end

  def test_sql_injection_CVE_2013_6417
    assert_warning :type => :warning,
      :warning_code => 69,
      :fingerprint => "e1b66f4311771d714a13be519693c540d7e917511a758827d9b2a0a7f958e40f",
      :warning_type => "SQL Injection",
      :line => nil,
      :message => /^Rails\ 4\.0\.0\ contains\ a\ SQL\ injection\ vul/,
      :confidence => 0,
      :relative_path => "Gemfile",
      :user_input => nil
  end

  def test_redirect_1
    assert_warning :type => :generic,
      :warning_code => 18,
      :fingerprint => "6d27826e07e583ba9c6ae1f33843089fd1d8b1a2c359e00bf636e64a85a47feb",
      :warning_type => "Redirect",
      :line => 14,
      :message => /^Possible\ unprotected\ redirect/,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/controllers/removal_controller.rb"
  end

  def test_session_setting_2
    assert_warning :type => :generic,
      :warning_code => 29,
      :fingerprint => "715ad9c0d76f57a6a657192574d528b620176a80fec969e2f63c88eacab0b984",
      :warning_type => "Session Setting",
      :line => 12,
      :message => /^Session\ secret\ should\ not\ be\ included\ in/,
      :confidence => 0,
      :relative_path => "config/initializers/secret_token.rb"
  end

  def test_cross_site_scripting_3
    assert_warning :type => :template,
      :warning_code => 2,
      :fingerprint => "598b957fea4a202a75e1d8101a8c21332b10b2c0e9ca4ffad6c18407bde6615d",
      :warning_type => "Cross Site Scripting",
      :line => 1,
      :message => /^Unescaped\ model\ attribute/,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/views/removal/_partial.html.erb"
  end

  def test_cross_site_scripting_4
    assert_warning :type => :template,
      :warning_code => 2,
      :fingerprint => "011d330ea62763eb61684cccc4169518b0876eadbab2b469e3526548f3da3795",
      :warning_type => "Cross Site Scripting",
      :line => 1,
      :message => /^Unescaped\ parameter\ value/,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/views/removal/controller_removed.html.erb"
  end

  def test_cross_site_scripting_5
    assert_warning :type => :template,
      :warning_code => 2,
      :fingerprint => "26da712dc3289b873b7928b54bde6da038cbf891ec11076897e062f32939863e",
      :warning_type => "Cross Site Scripting",
      :line => 2,
      :message => /^Unescaped\ parameter\ value/,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/views/removal/implicit_render.html.erb"
  end

  def test_cross_site_scripting_6
    assert_warning :type => :template,
      :warning_code => 2,
      :fingerprint => "52c513069319d44e03c5ac21806d47c1f05393fe35a5026314c8064f70ff0375",
      :warning_type => "Cross Site Scripting",
      :line => 1,
      :message => /^Unescaped\ model\ attribute/,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/views/users/_form.html.erb"
  end

  def test_cross_site_scripting_7
    assert_warning :type => :template,
      :warning_code => 2,
      :fingerprint => "9d94ba6993f761ff688b5a8d428c793486cd8bf42f487a44d895a96f658dca50",
      :warning_type => "Cross Site Scripting",
      :line => 6,
      :message => /^Unescaped\ parameter\ value/,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/views/users/_slimmer.html.slim"
  end

  def test_cross_site_scripting_8
    assert_warning :type => :template,
      :warning_code => 2,
      :fingerprint => "9d576795978cf6681a0cd17f7250ea267ab2ac7888dd5f6100331d5c0684beb3",
      :warning_type => "Cross Site Scripting",
      :line => 8,
      :message => /^Unescaped\ model\ attribute/,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/views/users/_slimmer.html.slim"
  end

  def test_cross_site_scripting_9
    assert_warning :type => :template,
      :warning_code => 2,
      :fingerprint => "822a9a031ab38ae9e2b3580ce6eb28e6372852f289c9e65b347a9182c918d551",
      :warning_type => "Cross Site Scripting",
      :line => 15,
      :message => /^Unescaped\ parameter\ value/,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/views/users/show.html.erb"
  end

  def test_cross_site_scripting_10
    assert_warning :type => :template,
      :warning_code => 2,
      :fingerprint => "aa06d3e4d8e00ccf6169d9293b1ef90365917c46fa21678d248494f7767d1d15",
      :warning_type => "Cross Site Scripting",
      :line => 3,
      :message => /^Unescaped\ parameter\ value/,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/views/users/slimming.html.slim"
  end

  def test_cross_site_scripting_11
    assert_warning :type => :template,
      :warning_code => 2,
      :fingerprint => "6628d5e2059d14b31e7c37251ac7380ddbe44e937d78d4e955763d5d53df08fc",
      :warning_type => "Cross Site Scripting",
      :line => 4,
      :message => /^Unescaped\ model\ attribute/,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/views/users/slimming.html.slim"
  end

  def test_mass_assignment_12
    assert_warning :type => :model,
      :warning_code => 60,
      :fingerprint => "6eab87f7d7a130b4762ba10184614f9f8780e95625857b11e42505ee4a82d04f",
      :warning_type => "Mass Assignment",
      #noline,
      :message => /^Potentially\ dangerous\ attribute\ 'plan_id/,
      :confidence => 2,
      :relative_path => "engines/user_removal/app/models/account.rb"
  end

  def test_mass_assignment_13
    assert_warning :type => :model,
      :warning_code => 60,
      :fingerprint => "9e552d6eac8dc68eb6e3a41cb838756802bcee812ab264e3d089d385566c4df0",
      :warning_type => "Mass Assignment",
      #noline,
      :message => /^Potentially\ dangerous\ attribute\ 'banned'/,
      :confidence => 1,
      :relative_path => "engines/user_removal/app/models/account.rb"
  end

  def test_mass_assignment_14
    assert_warning :type => :model,
      :warning_code => 60,
      :fingerprint => "fab5f6c9c06598732046931ee76049f31549502dd77b70dcf93562f62e81a3c0",
      :warning_type => "Mass Assignment",
      #noline,
      :message => /^Potentially\ dangerous\ attribute\ 'account/,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/models/user.rb"
  end

  def test_mass_assignment_15
    assert_warning :type => :model,
      :warning_code => 60,
      :fingerprint => "9b1cfaefacee0db06a58f558fb8dd6631fc43684da3c86368f0bfaf5cb6916e0",
      :warning_type => "Mass Assignment",
      #noline,
      :message => /^Potentially\ dangerous\ attribute\ 'admin'\ /,
      :confidence => 0,
      :relative_path => "engines/user_removal/app/models/user.rb"
  end

  def test_mass_assignment_16
    assert_warning :type => :model,
      :warning_code => 60,
      :fingerprint => "1668dd521bfcd7e2b387bcd5d636a35da24a7554eb612cc6096dc6bc41bb984f",
      :warning_type => "Mass Assignment",
      #noline,
      :message => /^Potentially\ dangerous\ attribute\ 'status_/,
      :confidence => 2,
      :relative_path => "engines/user_removal/app/models/user.rb"
  end

end
