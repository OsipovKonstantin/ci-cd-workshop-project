drop TABLE IF EXISTS projects, employees, tasks, technologies, tasks_technologies, employees_technologies, subtasks,
 employees_tasks, courses, courses_technologies, employees_courses, projects_tasks;

create table if not exists projects (
  id bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255) NOT NULL,
  status VARCHAR(100) NOT NULL,
  CONSTRAINT pk_project PRIMARY KEY (id),
  CONSTRAINT uq_projects_for_name UNIQUE (name)
  );

create table if not exists employees (
  id bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  fist_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  patronymic VARCHAR(255) NOT NULL,
  nik VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  timeZone VARCHAR(10) NOT NULL,
  login VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  birthday date,
  role VARCHAR(100) NOT NULL,
  CONSTRAINT pk_useremployee PRIMARY KEY (id),
  CONSTRAINT uq_employees_name_login UNIQUE (login)
);

create table if not exists tasks (
  id bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  priority INTEGER NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  creator_id BIGINT NOT NULL,
  executor_id BIGINT,
  duration INTEGER NOT NULL,
  start_date TIMESTAMP WITHOUT TIME ZONE,
  finish_date TIMESTAMP WITHOUT TIME ZONE,
  status VARCHAR(255),
  basic_points INTEGER NOT NULL,
  points INTEGER,
  CONSTRAINT pk_task PRIMARY KEY (id),
  CONSTRAINT fk_comeve_on_creator foreign key (creator_id) references employees (id),
  CONSTRAINT fk_comeve_on_executor foreign key (executor_id) references employees (id),
  CONSTRAINT uq_tasks_for_name UNIQUE (name)
);

  create table if not exists projects_tasks (
  project_id bigint not null,
  task_id bigint not null,
  constraint pk_projects_events primary key (project_id, task_id),
  constraint fk_comeve_on_project foreign key (project_id) references projects (id),
  constraint fk_comeve_on_task foreign key (task_id) references tasks (id)
);

create table if not exists technologies (
  id bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255) NOT NULL,
  CONSTRAINT pk_technology PRIMARY KEY (id),
  CONSTRAINT uq_technologies_for_name UNIQUE (name)
  );

create table if not exists subtasks (
  task_id bigint not null,
  subtask_id bigint not null,
  constraint pk_stak_subtasks primary key (task_id, subtask_id),
  constraint fk_comeve_on_task foreign key (task_id) references tasks (id),
  constraint fk_comeve_on_subtask foreign key (subtask_id) references tasks (id)
);

create table if not exists courses (
  id bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255) NOT NULL,
  link VARCHAR(255),
  start_date TIMESTAMP WITHOUT TIME ZONE,
  finish_date TIMESTAMP WITHOUT TIME ZONE,
  CONSTRAINT pk_course PRIMARY KEY (id),
  CONSTRAINT uq_courses_for_name UNIQUE (name)
  );

 create table if not exists courses_technologies (
  course_id bigint not null,
  technology_id bigint not null,
  constraint pk_cources_technologies primary key (course_id, technology_id),
  constraint fk_comeve_on_course foreign key (course_id) references courses (id),
  constraint fk_comeve_on_technology foreign key (technology_id) references technologies (id)
);

 create table if not exists tasks_technologies (
  task_id bigint not null,
  technology_id bigint not null,
  constraint pk_tasks_technologies primary key (task_id, technology_id),
  constraint fk_comeve_on_task foreign key (task_id) references tasks (id),
  constraint fk_comeve_on_technology foreign key (technology_id) references technologies (id)
);

create table if not exists employees_technologies (
  employee_id bigint not null,
  technology_id bigint not null,
  constraint pk_employees_technologies primary key (employee_id, technology_id),
  constraint fk_comeve_on_employee foreign key (employee_id) references employees (id),
  constraint fk_comeve_on_technology foreign key (technology_id) references technologies (id)
);

create table if not exists employees_courses (
  employee_id bigint not null,
  course_id bigint not null,
  constraint pk_employees_courses primary key (employee_id, course_id),
  constraint fk_comeve_on_course foreign key (course_id) references courses (id),
  constraint fk_comeve_on_employee foreign key (employee_id) references employees (id)
);
