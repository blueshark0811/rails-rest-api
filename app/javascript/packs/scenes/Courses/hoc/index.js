import React, { Component } from 'react';
import data from 'scenes/Courses/data.json';

const subscribingOnCourses = WrappedComponent => {
  class EnhancedCourses extends Component {
    constructor() {
      super();
      this.state = {
        courses: data
      };
    }

    render() {
      return <WrappedComponent {...this.props} courses={this.state.courses} />;
    }
  }

  return EnhancedCourses;
};

export default subscribingOnCourses;
