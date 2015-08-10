require_relative 'model_utils'

class Links

    attr_reader :self, :root, :type, :main_teacher, :course_unit,
                :lective_semester, :classes, :pages, :participants,
                :groups, :lectures, :news_items, :work_items, :resources


    def initialize(links, tpe)
        @self = links[ModelUtils::SELF] #unless links[ModelUtils::SELF].nil?
        @root = links[ModelUtils::ROOT] #unless links[ModelUtils::ROOT].nil?
        @type = links[tpe] #unless links[tpe].nil?

        @main_teacher = links[ModelUtils::MAIN_TEACHER]
        @course_unit = links[ModelUtils::COURSE_UNIT]
        @lective_semester = links[ModelUtils::LECTIVE_SEMESTER]
        @classes = links[ModelUtils::CLASSES]
        @pages = links[ModelUtils::PAGES]
        @participants = links[ModelUtils::PARTICIPANTS]
        @groups = links[ModelUtils::GROUPS]
        @lectures = links[ModelUtils::LECTURES]
        @news_items = links[ModelUtils::NEWS_ITEMS]
        @work_items = links[ModelUtils::WORK_ITEMS]
        @resources = links[ModelUtils::RESOURCES]

    end
end
