# Used to indicate a failure in the server to find the requested
# object id

class SpecWireExeption < StandardError; end

class ObjectNotFound < SpecWireExeption; end

class MethodError < SpecWireExeption; end

class ServerError < SpecWireExeption; end
