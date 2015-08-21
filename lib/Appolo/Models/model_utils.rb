module ModelUtils

  NAME = 'name'
  SHORT_NAME = 'shortName'
  ID = 'id'
  NUMBER = 'number'
  GITHUB_USERNAME = 'gitHubUsername'
  ACADEMIC_EMAIL = 'academicEmail'
  AVATAR_URL = 'avatarUrl'
  LINKS = '_links'

  SELF = 'self'
  ROOT = 'root'
  PROGRAM = 'program'

  FULL_NAME = 'fullName'
  COURSE_UNIT_SHORT_NAME = 'courseUnitShortName'
  LECTIVE_SEMESTER_SHORT_NAME = 'lectiveSemesterShortName'
  LECTIVE_SEMESTER = 'lectiveSemester'
  CLASS_NAME = 'className'
  CLASSES = 'classes'
  CLASS_ID = 'classId'
  MAIN_TEACHER_SHORT_NAME = 'mainTeacherShortName'
  COURSE_UNIT_ID = 'courseUnitId'
  COURSE_UNIT = 'courseUnit'
  LECTIVE_SEMESTER_ID = 'lectiveSemesterId'
  MAIN_TEACHER_ID = 'mainTeacherId'
  MAX_GROUP_SIZE = 'maxGroupSize'
  MAIN_TEACHER = 'mainTeacher'

  LECTIVE_ID = 'lectiveSemesterId'
  START_YEAR = 'startYear'
  TERM = 'term'
  TERM_NAME = 'termName'
  OTHER_TEACHERS = 'otherTeachers'
  PAGES = 'pages'
  PARTICIPANTS = 'participants'
  GROUPS = 'groups'
  LECTURES = 'lectures'
  NEWS_ITEMS = 'newsItems'
  WORK_ITEMS = 'workItems'
  RESOURCES = 'resources'

  CONTENT = 'content'
  DATE_CREATED = 'dateCreated'
  CREATED_WHEN = 'when'
  TITLE = 'title'
  DESCRIPTION = 'description'

  def self.check_json_info(json_info)
    if json_info.is_a? Hash
      json_data = json_info
    else
      json_data = JSON.parse json_info
    end
    json_data
  end

end