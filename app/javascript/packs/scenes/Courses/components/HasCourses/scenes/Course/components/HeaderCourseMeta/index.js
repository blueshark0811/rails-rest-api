import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import IconArrowRight from 'react-icons/lib/fa/angle-right';
import IconArrowDown from 'react-icons/lib/fa/angle-down';

import LinkButton from 'base_components/LinkButton';
import Box from 'base_components/Box';
import CollapsibleCourseHeaderPanel from './components/CollapsibleCourseHeaderPanel';
import bgImage from './course-bg.png';
import './styles.css';

// Report button component.
const ReportButton = styled(LinkButton)`
  margin-right: 1.1em;

  @media screen and (max-width: 767px) {
    display: none;
  }
`;

// Report Container component.
const ReportContainer = styled.div`
  display: flex;
  align-items: center;
`;

class HeaderCourseMeta extends PureComponent {
  constructor(...args) {
    super(...args);
    this.state = {
      open: false
    };
  }

  triggerPanel = e => {
    e.preventDefault();
    this.setState({
      open: !this.state.open
    });
  };

  render() {
    const { title, description } = this.props.course;
    return (
      <div>
        <Box
          style={{
            backgroundImage: `url(${bgImage})`
          }}
          className="HeaderCourseMeta"
        >
          <header>
            <div>
              <h3>{title}</h3>
              <a
                className="HeaderCourseMeta__toggleLink"
                onClick={this.triggerPanel}
              >
                About this course
                <span className="HeaderCourseMeta__button">
                  {this.state.open ? <IconArrowDown /> : <IconArrowRight />}
                </span>
              </a>
            </div>
            <div>
              <ReportContainer>
                <ReportButton secondary text="Report" url="/report" />
                <div className="HeaderCourseMeta__completed">
                  <div>
                    <span>2 of 3</span>
                    <span>completed</span>
                  </div>
                </div>
              </ReportContainer>
            </div>
          </header>
        </Box>
        <CollapsibleCourseHeaderPanel
          description={description}
          isOpen={this.state.open}
        />
      </div>
    );
  }
}

HeaderCourseMeta.propTypes = {
  course: PropTypes.object.isRequired
};

export default HeaderCourseMeta;
