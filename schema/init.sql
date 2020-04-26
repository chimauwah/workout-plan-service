# CREATE schema activity;
# CREATE USER 'localuser'@'%'
#   IDENTIFIED BY 'localuser';
# GRANT ALL PRIVILEGES ON activity.* TO 'localuser'@'%';
# USE activity;

drop table if exists activity.activity;
drop table if exists activity.muscle_group_mapping;
drop table if exists activity.day_group_mapping;

CREATE TABLE activity.activity
(
  id               int  auto_increment primary key,
  name             varchar(45)                                                                                                                   not null,
  muscle           enum ('ANKLE', 'ACHILLES', 'CALF', 'ADDUCTORS', 'GLUTE', 'HIP', 'ARMS', 'BACK', 'CHEST', 'CORE', 'SHOULDERS', 'LEG', 'QUADS') not null,
  category         enum ('exercise', 'resistance', 'stretch', 'tissue (AM)', 'tissue (PM)')                                                      not null,
  consecutive_days int  default 0,
  active           bool default true,
  constraint id_UNIQUE unique (id),
  constraint activity_UNIQUE unique (name, muscle, category)
);

-- achilles movements
-- tissue
-- stretching
INSERT INTO activity.activity (name, muscle, category) VALUES ('Standing Achilles stretch', 'ACHILLES', 'stretch');
-- exercises

-- adductor movements
-- tissue
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('inner thigh foam rolling', 'ADDUCTORS', 'tissue (AM)', false);
-- stretching
INSERT INTO activity.activity (name, muscle, category) VALUES ('frog stretch', 'ADDUCTORS', 'stretch');
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('frog stretch with leg out', 'ADDUCTORS', 'stretch', false);
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('butterfly stretch', 'ADDUCTORS', 'stretch', false);
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('Lying leg out to side stretch (with strap)', 'ADDUCTORS', 'stretch', false);
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('side to side lunge', 'ADDUCTORS', 'stretch', false);
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('prayer squat stretch', 'ADDUCTORS', 'stretch', false);
INSERT INTO activity.activity (name, muscle, category) VALUES ('standing adductor stretch', 'ADDUCTORS', 'stretch');
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('Spiderman with adductor stretch', 'ADDUCTORS', 'stretch', false);
INSERT INTO activity.activity (name, muscle, category) VALUES ('Half kneeling groin & ankle mobility stretch', 'ADDUCTORS', 'stretch');
-- exercises,active
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('kneeling slider abduction', 'ADDUCTORS', 'exercise', false);
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('standing slide side lunge', 'ADDUCTORS', 'exercise', false);
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('sumo squat (with weight)', 'ADDUCTORS', 'exercise', false);
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('Side plank with adductor lift', 'ADDUCTORS', 'exercise', false);
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('peak-a-boo', 'ADDUCTORS', 'exercise', false);
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('lower ab criss cross', 'ADDUCTORS', 'exercise', false);
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('lying adductor lift', 'ADDUCTORS', 'exercise', false);

-- ankle movements
-- tissue
-- stretching
INSERT INTO activity.activity (name, muscle, category) VALUES ('Kneeling Foot Stretch To Bear Squat', 'ANKLE', 'stretch');
-- exercises
INSERT INTO activity.activity (name, muscle, category) VALUES ('Single leg balance', 'ANKLE', 'exercise');
INSERT INTO activity.activity (name, muscle, category) VALUES ('Single leg hip hinge (RDL)', 'ANKLE', 'exercise');
INSERT INTO activity.activity (name, muscle, category) VALUES ('Half round ankle sway', 'ANKLE', 'exercise');
INSERT INTO activity.activity (name, muscle, category) VALUES ('Reverse lunges', 'ANKLE', 'exercise');

-- arms movements
-- tissue
-- stretching
-- exercises
INSERT INTO activity.activity (name, muscle, category) VALUES ('arm workout', 'ARMS', 'resistance');

-- back movements
-- tissue
-- stretching
-- exercises
INSERT INTO activity.activity (name, muscle, category) VALUES ('back workout', 'BACK', 'resistance');

-- calf movements
-- tissue
INSERT INTO activity.activity (name, muscle, category) VALUES ('Peroneal Foam Rolling', 'CALF', 'tissue (AM)');
INSERT INTO activity.activity (name, muscle, category) VALUES ('calf foam rolling (with ankle rolls)', 'CALF', 'tissue (AM)');
-- stretching
INSERT INTO activity.activity (name, muscle, category) VALUES ('Standing calf stretch', 'CALF', 'stretch');
INSERT INTO activity.activity (name, muscle, category) VALUES ('Calf stretch on step (half round)', 'CALF', 'stretch');
-- exercises
INSERT INTO activity.activity (name, muscle, category) VALUES ('Single leg standing calf raise', 'CALF', 'exercise');

-- chest movements
-- tissue
-- stretching
-- exercises
INSERT INTO activity.activity (name, muscle, category) VALUES ('chest workout', 'CHEST', 'resistance');

-- core movements
-- tissue
-- stretching
-- exercises
INSERT INTO activity.activity (name, muscle, category) VALUES ('plank circuit', 'CORE', 'exercise');
INSERT INTO activity.activity (name, muscle, category) VALUES ('bird dog', 'CORE', 'exercise');

-- glute movements
-- tissue
INSERT INTO activity.activity (name, muscle, category) VALUES ('foam roll glutes', 'GLUTE', 'tissue (PM)');
-- stretching
INSERT INTO activity.activity (name, muscle, category) VALUES ('bench glute stretch', 'GLUTE', 'stretch');
INSERT INTO activity.activity (name, muscle, category) VALUES ('glute bridge', 'GLUTE', 'stretch');
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('3-way seated abduction', 'GLUTE', 'stretch', false);
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('pigeon hinge glute activation', 'GLUTE', 'stretch', false );
-- exercises
INSERT INTO activity.activity (name, muscle, category) VALUES ('leg kickbacks', 'GLUTE', 'exercise');
INSERT INTO activity.activity (name, muscle, category) VALUES ('sidelying leg lifts', 'GLUTE', 'exercise');
INSERT INTO activity.activity (name, muscle, category) VALUES ('clams', 'GLUTE', 'exercise');
INSERT INTO activity.activity (name, muscle, category) VALUES ('monster walk (with band)', 'GLUTE', 'exercise');
INSERT INTO activity.activity (name, muscle, category) VALUES ('donkey kicks (with band)', 'GLUTE', 'exercise');
INSERT INTO activity.activity (name, muscle, category) VALUES ('Glute Medius Wall Lean', 'GLUTE', 'exercise');

-- hip movements
-- tissue
INSERT INTO activity.activity (name, muscle, category) VALUES ('psoas self-release', 'HIP', 'tissue (PM)');
INSERT INTO activity.activity (name, muscle, category) VALUES ('foam roll psoas & TFL', 'HIP', 'tissue (AM)');
-- stretching
INSERT INTO activity.activity (name, muscle, category) VALUES ('couch stretch (with contractions)', 'HIP', 'stretch');
INSERT INTO activity.activity (name, muscle, category) VALUES ('couch stretch variation', 'HIP', 'stretch');
INSERT INTO activity.activity (name, muscle, category) VALUES ('rocking hip flexor stretch', 'HIP', 'stretch');
INSERT INTO activity.activity (name, muscle, category) VALUES ('Spiderman with thoracic rotation', 'HIP', 'stretch');
INSERT INTO activity.activity (name, muscle, category) VALUES ('TFL/IT Band stretch', 'HIP', 'stretch');
INSERT INTO activity.activity (name, muscle, category) VALUES ('Wall kneeling TFL stretch', 'HIP', 'stretch');
-- exercises

-- leg movements
-- tissue
-- stretching
-- exercises
INSERT INTO activity.activity (name, muscle, category, active) VALUES ('leg workout', 'LEG', 'resistance',false);

-- quad movements
-- tissue
INSERT INTO activity.activity (name, muscle, category) VALUES ('foam roll quads & IT band', 'QUADS', 'tissue (AM)');
INSERT INTO activity.activity (name, muscle, category) VALUES ('VMO MFR', 'QUADS', 'tissue (AM)');
INSERT INTO activity.activity (name, muscle, category) VALUES ('Quads MFR on half round', 'QUADS', 'tissue (PM)');
-- stretching
-- exercises
INSERT INTO activity.activity (name, muscle, category,active) VALUES ('Standing leg extensions', 'QUADS', 'exercise',false );

-- shoulder movements
-- tissue
-- stretching
-- exercises
INSERT INTO activity.activity (name, muscle, category) VALUES ('shoulder workout', 'SHOULDERS', 'resistance');


create table activity.day_group_mapping
(
  id       int auto_increment primary key,
  day      enum ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY') not null,
  `group`  varchar(45)                                                                         not null,
  category enum ('exercise', 'resistance', 'stretch', 'tissue')                                not null,
  max      int                                                                                 null,
  constraint day_group_category_UNIQUE unique (day, `group`, category)
);

INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('MONDAY', 'SHOULDERS', 'resistance', 1);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('MONDAY', 'upper_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('MONDAY', 'lower_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('MONDAY', 'upper_leg', 'stretch', 3);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('MONDAY', 'upper_leg', 'exercise', 3);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('TUESDAY', 'CHEST', 'resistance', 1);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('TUESDAY', 'upper_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('TUESDAY', 'lower_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('TUESDAY', 'lower_leg', 'stretch', 2);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('TUESDAY', 'lower_leg', 'exercise', 3);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('WEDNESDAY', 'upper_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('WEDNESDAY', 'lower_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('WEDNESDAY', 'upper_leg', 'stretch', 3);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('WEDNESDAY', 'upper_leg', 'exercise', 3);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('THURSDAY', 'ARMS', 'resistance', 1);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('THURSDAY', 'upper_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('THURSDAY', 'lower_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('THURSDAY', 'upper_leg', 'stretch', 3);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('THURSDAY', 'upper_leg', 'exercise', 3);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('FRIDAY', 'BACK', 'resistance', 1);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('FRIDAY', 'upper_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('FRIDAY', 'lower_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('FRIDAY', 'lower_leg', 'stretch', 3);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('FRIDAY', 'lower_leg', 'exercise', 3);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('SATURDAY', 'CHEST', 'resistance', 1);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('SATURDAY', 'upper_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('SATURDAY', 'lower_leg', 'tissue', 100);
INSERT INTO activity.day_group_mapping (day, `group`, category, max) VALUES ('SATURDAY', 'upper_leg', 'stretch', 3);

create table activity.muscle_group_mapping
(
  id      int auto_increment primary key,
  `group` varchar(45)                                                                                                            not null,
  muscle  enum ('ANKLE', 'ACHILLES', 'ADDUCTORS', 'CALF', 'CORE', 'GLUTE', 'HIP', 'SHOULDERS', 'ARMS', 'CHEST', 'BACK', 'QUADS') not null,
  constraint group_muscle_UNIQUE UNIQUE (`group`, muscle)
);

INSERT INTO activity.muscle_group_mapping (`group`, muscle) VALUES ('lower_leg', 'ANKLE');
INSERT INTO activity.muscle_group_mapping (`group`, muscle) VALUES ('lower_leg', 'ACHILLES');
INSERT INTO activity.muscle_group_mapping (`group`, muscle) VALUES ('lower_leg', 'CALF');
INSERT INTO activity.muscle_group_mapping (`group`, muscle) VALUES ('lower_leg', 'ADDUCTORS');
INSERT INTO activity.muscle_group_mapping (`group`, muscle) VALUES ('upper_leg', 'GLUTE');
INSERT INTO activity.muscle_group_mapping (`group`, muscle) VALUES ('upper_leg', 'HIP');
INSERT INTO activity.muscle_group_mapping (`group`, muscle) VALUES ('upper_leg', 'QUADS');
INSERT INTO activity.muscle_group_mapping (`group`, muscle) VALUES ('SHOULDERS', 'SHOULDERS');
INSERT INTO activity.muscle_group_mapping (`group`, muscle) VALUES ('CHEST', 'CHEST');
INSERT INTO activity.muscle_group_mapping (`group`, muscle) VALUES ('ARMS', 'ARMS');
INSERT INTO activity.muscle_group_mapping (`group`, muscle) VALUES ('BACK', 'BACK');