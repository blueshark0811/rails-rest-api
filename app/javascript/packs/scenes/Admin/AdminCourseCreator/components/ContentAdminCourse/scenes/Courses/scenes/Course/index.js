import React from 'react';
import { split, join, pipe } from 'ramda';
// component
import { BreadcrumbsItem } from 'react-breadcrumbs-dynamic/dist/src';
import HeaderCourseMeta from './components/HeaderCourseMeta';
import BodyCourseMeta from './components/BodyCourseMeta';

const Course = ({ match }) => {
  // cachce variables
  const paramId = match.params.id;
  /* create the course title based on the url params*/
  const courseTitle = pipe(split('-'), join(' '))(paramId);

  return (
    <div>
      <BreadcrumbsItem to={match.url}>{courseTitle}</BreadcrumbsItem>
      <HeaderCourseMeta courseTitle={courseTitle} />
      <BodyCourseMeta />
    </div>
  );
};

export default Course;
