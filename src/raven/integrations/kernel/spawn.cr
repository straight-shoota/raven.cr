def spawn(*, name : String? = nil, &block)
  # ameba:disable Style/RedundantBegin
  wrapped_block = ->{
    begin
      block.call
    rescue ex
      Raven.capture(ex, extra: {
        in_fiber:   true,
        fiber_name: name,
      })
      raise ex
    end
  }
  previous_def(name: name, &wrapped_block)
end