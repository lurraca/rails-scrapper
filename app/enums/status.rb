class Status < ClassyEnum::Base
end

class Status::Started < Status
end

class Status::Running < Status
end

class Status::Failed < Status
end

class Status::Complete < Status
end
