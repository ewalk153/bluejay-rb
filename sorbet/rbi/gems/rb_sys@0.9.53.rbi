# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rb_sys` gem.
# Please instead update this file by running `bin/tapioca gem rb_sys`.

# THIS FILE IS AUTO-GENERATED BY `rake data:derive`
#
# source://rb_sys//lib/rb_sys/version.rb#3
module RbSys; end

# source://rb_sys//lib/rb_sys.rb#7
class RbSys::Error < ::StandardError; end

# A class to get information about the Rust toolchains, and how they map to
# Ruby platforms.
#
# @example
#   RbSys::ToolchainInfo.new("x86_64-unknown-linux-gnu").ruby_platform # => "x86_64-linux"
#   RbSys::ToolchainInfo.new("x86_64-unknown-linux-gnu").supported? # => true
#   RbSys::ToolchainInfo.new("x86_64-unknown-linux-gnu")
#
# source://rb_sys//lib/rb_sys/toolchain_info/data.rb#6
class RbSys::ToolchainInfo
  # @return [ToolchainInfo] a new instance of ToolchainInfo
  #
  # source://rb_sys//lib/rb_sys/toolchain_info.rb#30
  def initialize(platform); end

  # source://rb_sys//lib/rb_sys/toolchain_info.rb#49
  def ==(other); end

  # Returns the value of attribute docker_platform.
  #
  # source://rb_sys//lib/rb_sys/toolchain_info.rb#14
  def docker_platform; end

  # Returns the value of attribute gem_platform.
  #
  # source://rb_sys//lib/rb_sys/toolchain_info.rb#14
  def gem_platform; end

  # Returns the value of attribute platform.
  #
  # source://rb_sys//lib/rb_sys/toolchain_info.rb#14
  def platform; end

  # Returns the value of attribute rake_compiler_dock_cc.
  #
  # source://rb_sys//lib/rb_sys/toolchain_info.rb#14
  def rake_compiler_dock_cc; end

  # Returns the value of attribute rake_compiler_dock_image.
  #
  # source://rb_sys//lib/rb_sys/toolchain_info.rb#14
  def rake_compiler_dock_image; end

  # Returns the value of attribute rust_target.
  #
  # source://rb_sys//lib/rb_sys/toolchain_info.rb#14
  def rust_target; end

  # Returns the value of attribute supported.
  #
  # source://rb_sys//lib/rb_sys/toolchain_info.rb#14
  def supported; end

  # @return [Boolean]
  #
  # source://rb_sys//lib/rb_sys/toolchain_info.rb#41
  def supported?; end

  # source://rb_sys//lib/rb_sys/toolchain_info.rb#45
  def to_s; end

  class << self
    # source://rb_sys//lib/rb_sys/toolchain_info.rb#17
    def all; end

    # source://rb_sys//lib/rb_sys/toolchain_info.rb#25
    def local; end

    # source://rb_sys//lib/rb_sys/toolchain_info.rb#21
    def supported; end
  end
end

# source://rb_sys//lib/rb_sys/toolchain_info/data.rb#7
RbSys::ToolchainInfo::DATA = T.let(T.unsafe(nil), Hash)

# source://rb_sys//lib/rb_sys/version.rb#4
RbSys::VERSION = T.let(T.unsafe(nil), String)
