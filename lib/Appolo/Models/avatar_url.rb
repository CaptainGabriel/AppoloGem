
class AvatarUrl

    attr_reader :size_24, :size_32, :size_64, :size_128


    def initialize(avatar_json_object)
        @size_24 = avatar_json_object['size24']
        @size_32 = avatar_json_object['size32']
        @size_64 = avatar_json_object['size64']
        @size_128 = avatar_json_object['size128']
    end
end