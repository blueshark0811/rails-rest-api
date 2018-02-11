import React, { Component } from 'react';
import data from 'scenes/Courses/data.json';

const subscribeToCourses = WrappedComponent => {
  // check if the input is component.
  if (typeof WrappedComponent === 'function') {
    class EnhancedTeacherControls extends Component {
      constructor() {
        super();
        this.state = {
          courses: []
        };
      }

      componentDidMount() {
        this.setState({
          courses: data
        });
      }

      render() {
        return (
          <WrappedComponent {...this.props} courses={this.state.courses} />
        );
      }
    }

    return EnhancedTeacherControls;
  }

  throw new Error('The input is not a component');
};

export default subscribeToCourses;
