#ifndef MATH_UTILITIES_H
#define MATH_UTILITIES_H

#include <Eigen/Core>
#include <Eigen/StdVector>

using namespace Eigen;
using namespace std;

namespace utilities
{

    pair<Vector2f, Vector2f> middleExtremes(pair<Vector2f, Vector2f> line1, pair<Vector2f, Vector2f> line2, int count)
    {
        // isolate extremes
        Vector2f head1 = line1.first;
        Vector2f tail1 = line1.second;
        Vector2f head2 = line2.first;
        Vector2f tail2 = line2.second;

        // middle diffs
        float head_dx = (float)fabs(head1(0)-head2(0))/2;
        float head_dy = (float)fabs(head1(1)-head2(1))/2;
        float tail_dx = (float)fabs(tail1(0)-tail2(0))/2;
        float tail_dy = (float)fabs(tail1(1)-tail2(1))/2;

        // prepare vectors
        Vector2f middle_head, middle_tail;

        // fill vectors
        middle_head << min(head1(0), head2(0))+head_dx, min(head1(1), head2(1))+head_dy;
        middle_tail << min(tail1(0), tail2(0))+tail_dx, min(tail1(1), tail2(1))+tail_dy;

//        cout << head_dx << "\t" << min(head1(0), head2(0)) << "\t" << min(head1(0), head2(0))+head_dx << endl <<
//                head_dy << "\t" << min(head1(1), head2(1)) << "\t" << min(head1(1), head2(1))+head_dy << endl <<
//                tail_dx << "\t" << min(tail1(0), tail2(0)) << "\t" << min(tail1(0), tail2(0))+tail_dx << endl <<
//                tail_dy << "\t" << min(tail1(1), tail2(1)) << "\t" << min(tail1(1), tail2(1))+tail_dy << endl << endl;

        stringstream ss, ss_line, file_name, line_name;
        file_name << "/home/ubisum/tesi/prova_match/stampe/stampa_" << count << ".txt";
        line_name << "/home/ubisum/tesi/prova_match/stampe/line_" << count << ".txt";
        remove(file_name.str().c_str());
        remove(line_name.str().c_str());
        FILE* output = fopen(file_name.str().c_str(), "a");
        FILE* line_output = fopen(line_name.str().c_str(), "a");

        ss << head1(0) << "\t" << head1(1) << "\n" <<
              tail1(0) << "\t" << tail1(1) << "\n\n" <<
              head2(0) << "\t" << head2(1) << "\n" <<
              tail2(0) << "\t" << tail2(1);

        ss_line << middle_head(0) << "\t" << middle_head(1) << "\n" <<
              middle_tail(0) << "\t" << middle_tail(1);

        fputs(ss.str().c_str(), output);
        fputs(ss_line.str().c_str(), line_output);

        // return vectors
        return make_pair(middle_head, middle_tail);

    }

}

#endif // MATH_UTILITIES_H
