require_relative 'test_helper'

# NodeObserverLibraryTest.
# @class_description
#   Tests the NodeObserverLibrary class.
class NodeObserverLibraryTest < Minitest::Test

  # Constants.
  NILCLASS_I = nil
  TEST_SYMBOL = :test_symbol
  NODE1 = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)

  # test_conf_doc_f_ex().
  # @description
  #   The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md,
  #   .yardopts, .gitignore, Changelog.md, CODE_OF_CONDUCT.md,
  #   node_observer.gemspec, Gemfile.lock, and Rakefile files exist.
  def test_conf_doc_f_ex()
    
    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
    assert_path_exists('.yardopts')
    assert_path_exists('.gitignore')
    assert_path_exists('Changelog.md')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('node_observer.gemspec')
    assert_path_exists('Gemfile.lock')
    assert_path_exists('Rakefile')
  
  end

  # test_version_declared().
  # @description
  #   The version was declared.
  def test_version_declared()
    refute_nil(NodeObserverLibrary::VERSION)
  end

  # setup().
  # @description
  #   Set fixtures.
  def setup()
  end

  # add_changed(n = nil).

  # test_ac_x2().
  # @description
  #   A subject.
  def test_ac_x2()

    singleton = NodeObserver.instance()
    singleton.add(NODE1)
    assert_raises(ArgumentError, "#{NODE1} is not a publisher.") {
      singleton.subject_changed(NODE1)
    }

  end

  # notify(n = nil).

  # test_notify_x1().
  # @description
  #   Any Node excluding feed publishers.
  def test_notify_x1()

    singleton = NodeObserver.instance()
    assert_raises(ArgumentError, "#{NODE1} is not a publisher.") {
      singleton.subject_changed(NODE1)
    }

  end

  # test_notify_x2().
  # @description
  #   A feed publisher argument.
  def test_notify_x2()

    singleton = NodeObserver.instance()
    singleton.add(NODE1)
    n_s_s = NodeSubscription.instance()
    n_s_s.add_publisher(NODE1)
    r = singleton.subject_changed(NODE1)
    assert_nil(r)
    refute_operator(singleton, 'changed_node', NODE1)

  end

  # remove_changed(n = nil).

  # test_rc_x2().
  # @description
  #   A changed subject argument.
  def test_rc_x2()

    singleton = NodeObserver.instance()
    singleton.add(NODE1)
    subscription_s = NodeSubscription.instance()
    subscription_s.add_publisher(NODE1)
    r = singleton.subject_changed(NODE1)
    assert_nil(r)
    refute_operator(singleton, 'changed_node', NODE1)

  end
  
  # teardown().
  # @description
  #   Cleanup.
  def teardown()

    o_singleton = NodeObserver.instance()
    if (o_singleton.subject(NODE1))
      o_singleton.remove(NODE1)
    end

  end
  
end
