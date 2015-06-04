#include "line_extractor.h"
#include <vector>
#include <Eigen/Core>
#include <Eigen/StdVector>
#include "stdio.h"
#include <fstream>
#include <string>
#include "matching_utilities.h"
#include "math_utilities.h"
#include "misc_utilities.h"

using namespace std;
using namespace Eigen;
using namespace utilities;


void findPoses(vector<completeInformation> ci){
    for(int i = 0; i<(int)ci.size()-1; i++)
    {
        if(ci[i].angle != ci[i+1].angle)
        {
            cout << "Coppia" << " " << i << " " << i+1 << endl;
            break;
        }
    }
}

void printLines(vecPairsList Lines, int index)
{
    cout << "entrata" << endl;
    stringstream ss_filename;
    ss_filename << "convertedLines_" << index << ".txt";

    remove(ss_filename.str().c_str());
    FILE* fid = fopen(ss_filename.str().c_str(), "a");
    cout << "prima for" << endl;

    for(int counter = 0; counter<(int)Lines.size(); counter++)
    {
        // a line
        vecPair vp = Lines[counter];
        Vector2f ex_1 = vp.first;
        Vector2f ex_2 = vp.second;

        // line representation
        Vector4f lineRep = lineRepresentation(vp.first, vp.second);

        // line's polar form
        Vector2f polar = polarRepresentation(vp.first, vp.second);

        // prepare a stringstream
        stringstream ss_lines;

        // write to file
        ss_lines << lineRep(0)<<  "\t" << lineRep(1) << "\t" << lineRep(2) << "\t" << lineRep(3) << "\t" <<
                    polar(0) << "\t" << polar(1) << "\t" <<
                    ex_1(0) << "\t" << ex_1(1) << "\t" <<
                    ex_2(0) << "\t" << ex_2(1) << "\n";
        fputs(ss_lines.str().c_str(), fid);

    }

}

int main(int argv, char** argc)
{
    vector<completeInformation> ci, parsed_info;
    vector<Vector2fVector> scanLines;
    vector<vecPairsList> extractedLines;
    vector<pair<Vector2f, Vector2f> > extremesCouples;
    parseRobotInfo("/home/ubisum/tesi/prova_match/files/robotInfo.txt", parsed_info);
    ci = selectFrames(parsed_info);


    int down = 100;
    int up = 102;

    remove("points.txt");
    FILE* points = fopen("points.txt", "a");

    for(int k = 0; k<(int)ci.size(); k++)
    {
        Vector2fVector vector;
        stringstream file_name;
        FILE* openFile;

        if(k>=down && k<up)
        {
            file_name << "points_" << k << ".txt";
            openFile = fopen(file_name.str().c_str(), "a");
        }

        for (int i = 0; i < (int)ci[k].points.size(); i++)
        {
            coordinate coord = ci[k].points[i];
            float xCoord = coord.first;
            float yCoord = coord.second;

            if(k>=down && k<up)
            {
                stringstream ss;
                ss << xCoord << "\t" << yCoord << "\n";
                fputs(ss.str().c_str(), openFile);
            }

            Vector2f v;
            v << xCoord, yCoord;
            vector.push_back(v);
        }

        scanLines.push_back(vector);
        extractedLines.push_back(computeLines(vector));
    }

    // line extraction test
    computeLines(scanLines[101]);

    // print converted lines to file
    remove("convertedLines.txt");
    FILE* convertedLines = fopen("convertedLines.txt", "a");

//    for(int j = 0; j<(int)extractedLines[0].size(); j++)
//    {
//        // get list of lines
//        vecPairsList Lines = extractedLines[0];

//        // prepare a stringstream
//        stringstream ss_lines;

//        // scan extracted lines
//        for(int counter = 0; counter<(int)Lines.size(); counter++)
//        {
//            // a line
//            vecPair vp = Lines[counter];
//            cout << "Scanline: " << Lines.size() << endl;

//            // line representation
//            Vector4f lineRep = lineRepresentation(vp.first, vp.second);

//            // line's polar form
//            Vector2f polar = polarRepresentation(vp.first, vp.second);

//            // prepare a stringstream
//            stringstream ss_lines;


//            // write to file
//            ss_lines << lineRep(0)<<  "\t" << lineRep(1) << "\t" << lineRep(2) << "\t" << lineRep(3) << "\t" <<
//                        polar(0) << "\t" << polar(1) << "\n";
//            fputs(ss_lines.str().c_str(), convertedLines);

//        }

//        cout << "Dati odometrici: " << ci[0].position.first << " " <<
//                ci[0].position.second << " " <<
//                ci[0].angle << endl;

//        cout << "Misure: " << extractedLines.size() << " " << ci.size() << endl;

        cout << "Selected frames: " << parsed_info.size() << " " << ci.size() << endl << endl;
        findPoses(ci);
        int first = 0;
        int second = 1;
        selectLines(extractedLines);

        cout << "Differenze: " << "\n" << ci[first].position.first << "\t" << ci[second].position.first << "\t" <<
                ci[second].position.first-ci[first].position.first << "\n" <<
                ci[first].position.second << "\t" << ci[second].position.second << "\t" <<
                ci[second].position.second-ci[first].position.second << "\n" <<
                ci[first].angle << "\t" << ci[second].angle << "\t" <<
                ci[second].angle-ci[first].angle << endl;
    //}

        cout << "print" << endl;
        cout << "Extracted lines: " << extractedLines.size() << endl;
        printLines(extractedLines[first], first);
        printLines(extractedLines[second], second);
        printLines(extractedLines[2], 2);
        printLines(extractedLines[3], 3);
}
